require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  test "should not save document when original_url field is nil" do
    new_url = Url.new(original_url: nil)

    assert_not new_url.valid?
    assert_not new_url.save
  end

  test "should not save document when original_url field is not formatted with 'http' or 'https'" do
    new_url = Url.new(original_url: "www.google.com")

    assert_not new_url.valid?
    assert_not new_url.save
  end

  test "should create and save valid url object" do
    new_url = Url.new(original_url: "https://www.google.com")

    assert new_url.save
  end

  test "should return short url after successful save" do
    new_url = Url.new(original_url: "https://www.duckduckgo.com")

    assert new_url.save
    # FIXME: Add environment
    assert_match "http://localhost:3000", new_url.guppy_url
  end

  test "should return _id of 7 characters in length" do
    new_url = Url.new(original_url: "https://www.yahoo.com")
    new_url.save

    assert_equal 7, new_url._id.length
  end
end
