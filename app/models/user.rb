class User < ActiveRecord::Base
  include RatingAverage
  has_many :ratings
  validates :username, uniqueness: true, length: { minimum: 3, maximum: 10 }
end
