class List < ActiveRecord::Base
  belongs_to :user
  has_many :items

  validates_presence_of :name
  validates_inclusion_of :permissions, in: %w( private viewable open ), message: "%{value} is not a valid permission"
end
