class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    n = ratings.count
    all = 0
    ratings.all.each do |r|
      all += r.score
    end
    return all/n
  end

end
