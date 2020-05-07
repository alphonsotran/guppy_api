require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  setup do
    @link = "https://www.google.com"
  end

  test "should not save document when originalUrl field is nil" do
    new_url = Url.new(originalUrl: nil)

    assert_not new_url.valid?
    assert_not new_url.save
  end

  test "should create and save valid url object" do
    new_url = Url.new(originalUrl: @link)

    assert new_url.save
  end

  test "should return _id of 7 characters in length" do
    new_url = Url.new(originalUrl: @link)
    new_url.save

    assert_equal 7, new_url._id.length
  end
end
