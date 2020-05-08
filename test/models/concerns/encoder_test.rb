require 'test_helper'

class EncoderTest < ActiveSupport::TestCase
  include Encoder

  test "should generate 7 character hash from link" do
    hash_url = generate_hash_from_url("https://www.msn.com")

    assert 7, hash_url.length
  end

  test "should generate different hash from different links" do
    hash_url_one = generate_hash_from_url("https://www.msn.com")
    hash_url_two = generate_hash_from_url("https://www.google.com")

    assert_not_equal hash_url_one, hash_url_two
  end

  test "should generate same hash from same links" do
    hash_url_one = generate_hash_from_url("https://www.msn.com/1234/sdfj")
    hash_url_two = generate_hash_from_url("https://www.msn.com/1234/sdfj")

    assert_equal hash_url_one, hash_url_two
  end

  test "should return different hash if salt is passed in with a link" do
    hash_url_one = generate_hash_from_url("https://www.msn.com", true)
    hash_url_two = generate_hash_from_url("https://www.msn.com")

    assert_not_equal hash_url_one, hash_url_two
  end

  test "should return nil if link is nil" do
    assert_not generate_hash_from_url(nil)
  end
end
