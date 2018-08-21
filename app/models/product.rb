class Product < ApplicationRecord
  belongs_to :category
  has_many :likes
  has_many :ratings
  has_many :comments
  has_many :order_details
  has_many :images
  has_many :promotion_details

  scope :get_product, -> {select :id, :name, :price}
  scope :like_most, -> {
    joins(:likes).group("product_id").order("count(user_id) DESC").
      limit(Settings.product.limit)
  }
end
