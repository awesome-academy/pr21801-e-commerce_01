class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  has_many :products, through: :order_details
  accepts_nested_attributes_for :order_details

  enum status: {pending: 0, delivered: 1, canceled: 2}
end
