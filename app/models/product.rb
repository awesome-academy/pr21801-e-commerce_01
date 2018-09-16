class Product < ApplicationRecord
  belongs_to :category
  has_many :likes
  has_many :ratings
  has_many :comments, dependent: :destroy
  has_many :order_details
  has_many :images
  has_many :promotion_details

  accepts_nested_attributes_for :images, allow_destroy: true,
    reject_if: proc { |attributes| attributes["image_url"].blank? }

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true,
    length: {maximum: Settings.product.validates.price_maximum},
    numericality: {only_integer: true, greater_than: 0}

  scope :get_product, ->{
    select :id, :name, :price, :description, :average_rating, :category_id
  }
  scope :like_most, ->{
    joins(:likes).group("product_id").order("count(user_id) DESC")
      .limit Settings.product.limit
  }
  scope :hot_product, ->{
    joins(:order_details).group("product_id").order("count(product_id) DESC")
      .limit Settings.product.hot
  }
end
