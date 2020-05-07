class Url
  include Mongoid::Document
  field :originalUrl, type: String

  validates :originalUrl, presence: true
  validates :url, format: URI::regexp(%w[http https])
end
