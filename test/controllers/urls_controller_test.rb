require 'test_helper'

class UrlsControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  setup do
    @link = "https://www.google.com"
  end

  test 'should create new url object' do
    post links_path params: { original_url: @link }, headers: { "CONTENT_TYPE" => "text/javascript"}
    json_response = JSON.parse(response.body)

    assert_match "http://localhost:3000", json_response["guppy_url"]
    assert_response :success
  end

  test 'should return status code 422 when url object is invalid' do
    post links_path params: { original_url: nil }, headers: { "CONTENT_TYPE" => "text/javascript"}

    assert_response :unprocessable_entity
  end

  test "should redirect when given id exists in the database" do
    new_url = Url.create(original_url: "https://www.altavista.com")

    get "/#{new_url._id}"

    assert_equal new_url.original_url, "https://www.altavista.com"
    assert_response :redirect
    assert_redirected_to new_url.original_url
  end

  test "should return 404 if link doesn't exist" do
    get "/abcdef"

    assert_response :not_found
  end
end