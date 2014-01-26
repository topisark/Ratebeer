class Brewery < ActiveRecord::Base
  has_many :beers
  has_many :ratings, through: :beers
  include RatingAverage
end
