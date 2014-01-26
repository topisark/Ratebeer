class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers, dependent: :destroy
  include RatingAverage
end
