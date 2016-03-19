class Style < ActiveRecord::Base
  has_many :beers
  has_many :ratings, through: :beers
  include RatingAverage

  def to_s
    return self.name
  end

end

