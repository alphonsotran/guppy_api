require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  test "should return shorten characters of 7 in length" do
    url = "https://www.google.com"
    new_url = Url.new(_id: '1234567', originalUrl: url)
    assert_equal(7, new_url._id.length)
  end


end
