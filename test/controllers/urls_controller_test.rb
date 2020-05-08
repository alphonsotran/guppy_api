require 'test_helper'

class UrlsControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  setup do
    @link = "https://www.google.com"
  end

  test 'should create new url object' do
    assert_difference('Url.count') do
      post '/links', params: { original_url: @link }
    end

    assert_response :success
  end

  test 'should return status code 422 when url object is invalid' do
    post '/links', params: { original_url: nil }

    assert_response :unprocessable_entity
  end
end