class BeerClub < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  validates :name, presence: true
end

def to_s
  return "#{self.name}"
end