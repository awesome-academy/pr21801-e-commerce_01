class User < ApplicationRecord
  has_many :likes
  has_many :ratings
  has_many :comments
  has_many :orders
end
