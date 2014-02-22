class User < ActiveRecord::Base
  include RatingAverage
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  has_many :beers, through: :ratings
  has_secure_password
  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
  validates :password, format: {with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,15}\z/, message: "requires one lowercase, one uppercase, one number and at least 4 characters."}

  def to_s
    return "#{self.username}"
  end

  def self.top(n)
    top = User.all.sort_by{|u| u.ratings.count}
    top = top.reverse
    return top.first(n)
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.order('score desc').limit(1).first.beer
  end

  def favorite_brewery
    favorite :brewery
  end

  def favorite_style
    favorite :style
  end

  private

  def favorite(category)
    return nil if ratings.empty?
    rating_pairs = rated(category).inject([]) do |pairs, item|
      pairs << [item, rating_average(category, item)]
    end
    rating_pairs.sort_by { |s| s.last }.last.first
  end

  def rated(category)
    ratings.map{ |r| r.beer.send(category) }.uniq
  end

  def rating_average(category, item)
    ratings_of_item = ratings.select{ |r|r.beer.send(category)==item }
    return 0 if ratings_of_item.empty?
    ratings_of_item.inject(0.0){ |sum ,r| sum+r.score } / ratings_of_item.count
  end

end
