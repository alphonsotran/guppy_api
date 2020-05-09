class UrlsController < ApplicationController

  def create
    new_url = Url.new(url_params)

    if new_url.save
      json_response(new_url, :created)
    else
      json_response({ message: new_url.errors.full_messages }, :unprocessable_entity)
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
end