class Brewery < ActiveRecord::Base
  has_many :beers
  has_many :ratings, through: :beers

  def average_rating
    return ratings.average('score')
    #return ratings.all.inject(0.0) {|sum, rating| sum+rating.score} / ratings.count
  end

end
