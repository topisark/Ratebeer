class BeerClub < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
end

def to_s
  return "#{self.name}"
end