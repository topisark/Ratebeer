class Beer < ActiveRecord::Base
  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :users, through: :ratings
  include RatingAverage
  validates :name, presence: true

  def to_s
    return "#{self.name} (#{self.brewery.name})"
  end


end


#f063efd4be83194eefec2cd139c7cad8