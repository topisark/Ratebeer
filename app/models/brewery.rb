class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers, dependent: :destroy
  include RatingAverage
  validates :name, presence: true
  validates :year, :inclusion => { :in => proc { 1042..0.years.ago.year } }

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating||0) }
    return sorted_by_rating_in_desc_order.first(n)
  end
end
