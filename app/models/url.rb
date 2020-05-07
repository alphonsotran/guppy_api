class Url
  include Mongoid::Document
  field :originalUrl, type: String

  validates :originalUrl, presence: { message: "Please type in a url" }
  validates :originalUrl, format: URI::regexp(%w[http https])

  before_validation :generate_shortener_as_id

  private
  def generate_shortener_as_id
    self._id = SecureRandom.uuid[0..6]
  end
end
