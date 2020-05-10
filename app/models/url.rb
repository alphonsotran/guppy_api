class Url
  include Mongoid::Document
  include Mongoid::Timestamps
  include Encoder

  field :original_url, type: String

  validates :original_url, presence: { message: "Please type in a url" }
  validates :original_url, format: URI::regexp(%w[http https])

  before_validation :generate_short_id

  def guppy_url
    # FIXME: Add env
    "http://localhost:3000/#{self._id}"
  end

  def generate_short_id(salt = false)
    self._id = generate_hash_from_url(self.original_url, salt)
  end
end
