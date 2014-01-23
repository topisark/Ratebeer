class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating

    return ratings.average('score')
    #return ratings.all.inject(0.0) {|sum, rating| sum+rating.score} / ratings.count

  end


end
