class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :stars, presence: true
end
