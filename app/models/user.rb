class User < ActiveRecord::Base
  include RatingAverage
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  has_secure_password
  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
  validates :password, format: {with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,15}\z/, message: "requires one lowercase, one uppercase, one number and at least 4 characters."}

  def to_s
    return "#{self.username}"
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.order('score desc').limit(1).first.beer
  end

end
