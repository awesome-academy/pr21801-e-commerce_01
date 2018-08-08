class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details

  enum status: {pending: 0, paid: 1, canceled: 2}
end
