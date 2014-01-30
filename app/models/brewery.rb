class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers, dependent: :destroy
  include RatingAverage
  validates :name, presence: true
  validates :year, numericality: {only_integer: true, greater_than: 1041, less_than: 2015 }
end
