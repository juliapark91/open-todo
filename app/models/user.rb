class User < ActiveRecord::Base
  has_many :lists
  
  validates_presence_of :username
  validates_presence_of :password
end
