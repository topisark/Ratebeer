class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers, dependent: :destroy
  include RatingAverage
  validates :name, presence: true
  validates :year, :inclusion => { :in => proc { 1042..0.years.ago.year } }
end
