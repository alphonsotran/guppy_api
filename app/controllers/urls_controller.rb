class UrlsController < ApplicationController

  def create
    new_url = Url.new(url_params)

    if new_url.save
      render json: guppy_url_response(new_url), status: :created
    else
      render json: ({ message: new_url.errors.full_messages }), status: :unprocessable_entity
    end
  end

  def show
    begin
      new_url = Url.find(url_params[:id])
      redirect_to new_url.original_url
    rescue Mongoid::Errors::DocumentNotFound => e
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
end