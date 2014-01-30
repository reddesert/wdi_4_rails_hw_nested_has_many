class User < ActiveRecord::Base
  validates_presence_of :name
  has_many :articles
end
