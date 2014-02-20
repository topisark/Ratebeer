class Beer < ActiveRecord::Base
  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :users, through: :ratings
  include RatingAverage
  validates :name, presence: true
  validates :style_id, presence: true

  def to_s
    return "#{self.name} (#{self.brewery.name})"
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating||0) }
    return sorted_by_rating_in_desc_order.first(n)
  end

end


#f063efd4be83194eefec2cd139c7cad8