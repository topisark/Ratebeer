class Beer < ActiveRecord::Base
  include RatingAverage
  include Top
  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :users, through: :ratings
  validates :name, presence: true
  validates :style_id, presence: true

  def to_s
    return name
  end

end
