class Product < ApplicationRecord
  belongs_to :category
  has_many :likes
  has_many :ratings
  has_many :comments
  has_many :order_details
  has_many :images
  has_many :promotion_details
end
