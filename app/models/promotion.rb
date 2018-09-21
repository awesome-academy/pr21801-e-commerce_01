class Promotion < ApplicationRecord
  has_many :promotion_details

  accepts_nested_attributes_for :promotion_details, allow_destroy: true

  validates :content, presence: true
  validates :percent, presence: true,
    numericality: {only_integer: true, greater_than: 0,
      less_than: Settings.promotion.maximum_percent}
end
