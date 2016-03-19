class Style < ActiveRecord::Base
  include RatingAverage
  include Top
  has_many :beers
  has_many :ratings, through: :beers

  def to_s
    return self.name
  end

end

