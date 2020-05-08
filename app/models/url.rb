class Url
  include Mongoid::Document
  include Encoder

  field :original_url, type: String

  validates :original_url, presence: { message: "Please type in a url" }
  validates :original_url, format: URI::regexp(%w[http https])

  before_validation :generate_shortener_as_id

  private
  def generate_shortener_as_id(salt = false)
    self._id = generate_hash_from_url(self.original_url, salt)
  end
end
