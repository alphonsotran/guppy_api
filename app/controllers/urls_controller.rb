class UrlsController < ApplicationController

  def create
    new_url = Url.new(url_params)

    if new_url.save
      json_response(new_url, :created)
    else
      json_response({ message: new_url.errors.full_messages }, :unprocessable_entity)
    end
  end

  private
  def url_params
    params.permit(:original_url)
  end
end