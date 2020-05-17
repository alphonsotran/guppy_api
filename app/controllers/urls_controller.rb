class UrlsController < ApplicationController
  def create
    new_url = Url.new(url_params)

    if cached_url(new_url._id).present?
      return render json: guppy_url_response(new_url), status: :ok
    end

    begin
      insert_to_db(new_url)
    rescue Mongo::Error::OperationFailure => e
      # puts "Rescued: Mongo Operation Failure: #{e.inspect}"
      render json: guppy_url_response(fetch_cache_or_db(new_url._id)), status: :created
    end
  end

  def show
    new_url = fetch_cache_or_db(url_params[:id])
    redirect_to new_url.original_url
  rescue Mongoid::Errors::DocumentNotFound => e
    # puts "Rescued: Mongo Document Not Found: #{e.inspect}"
    render 'errors/404', status: :not_found
  end

  private

  def url_params
    params.permit(:original_url, :id)
  end

  def insert_to_db(obj)
    if obj.save
      render json: guppy_url_response(obj), status: :created
    else
      render json: { message: obj.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def guppy_url_response(object)
    object.as_json(
      only: [:original_url],
      methods: [:guppy_url]
    )
  end

  def cached_url(current_id)
    Rails.cache.read(current_id)
  end

  def fetch_cache_or_db(current_id)
    Rails.cache.fetch(current_id.to_s, expires_in: 1.week) do
      Url.find(current_id)
    end
  end
end
