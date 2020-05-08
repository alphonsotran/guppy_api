module Encoder
  def generate_hash_from_url(link, salt = false)
    return unless link.present?

    url = salt.present? ? "#{link}#{DateTime.now}" : link
    encode_url(url)
  end

  private
  def encode_url(link)
    Base64.urlsafe_encode64(Digest::MD5.hexdigest(link))[0..6]
  end
end