class Brewery < ActiveRecord::Base
  include RatingAverage
  include Top
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers, dependent: :destroy
  validates :name, presence: true
  validates :year, :inclusion => { :in => proc { 1042..0.years.ago.year } }

  scope :active, -> { where active:true }

  def to_s
    name
  end

end
