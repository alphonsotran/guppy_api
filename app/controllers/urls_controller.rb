class UrlsController < ApplicationController

  def create
    new_url = Url.new(url_params)
    new_url_id = new_url.generate_short_id()
    return render json: guppy_url_response(new_url), status: :ok if cached_url(new_url_id).present?

    begin
      if new_url.save
        render json: guppy_url_response(new_url), status: :created
      else
        render json: ({ message: new_url.errors.full_messages }), status: :unprocessable_entity
      end
    rescue Mongo::Error::OperationFailure => e
      # puts "Rescued: Mongo Operation Failure: #{e.inspect}"
      render json: guppy_url_response(fetch_cache_or_db(new_url_id)), status: :created
    end
  end

  def show
    begin
      new_url = fetch_cache_or_db(url_params[:id])
      redirect_to new_url.original_url
    rescue Mongoid::Errors::DocumentNotFound => e
      # puts "Rescued: Mongo Document Not Found: #{e.inspect}"
      render 'errors/404', status: 404
    end
  end

  private

  def url_params
    params.permit(:original_url, :id)
  end

  def guppy_url_response(object)
    object.as_json(
      only: [:original_url],
      methods: [:guppy_url],
    )
  end

  def cached_url(current_id)
    Rails.cache.read(current_id)
  end

  def fetch_cache_or_db(current_id)
    Rails.cache.fetch("#{current_id}", expires_in: 1.week) do
      Url.find(current_id)
    end
  end
end