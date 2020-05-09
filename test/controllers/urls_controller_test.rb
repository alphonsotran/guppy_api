require 'test_helper'

class UrlsControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  setup do
    @link = "https://www.google.com"
  end

  test 'should create new url object' do
    assert_difference('Url.count') do
      post links_path params: { original_url: @link }, headers: { "CONTENT_TYPE" => "text/javascript"}
    end

    assert_response :success
  end

  test 'should return status code 422 when url object is invalid' do
    post links_path params: { original_url: nil }, headers: { "CONTENT_TYPE" => "text/javascript"}

    assert_response :unprocessable_entity
  end
end