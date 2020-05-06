class Url
  include Mongoid::Document
  field :originalUrl, type: String

  validates :originalUrl, presence: true
end
