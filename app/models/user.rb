class User < ActiveRecord::Base
  include RatingAverage
  has_many :ratings
  has_many :raters, through: :ratings, source: :user
  has_many :memberships
  has_many :beer_clubs, through: :memberships
  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }

  def to_s
    return "#{self.username}"
  end
end
