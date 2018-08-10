class Category < ApplicationRecord
  has_many :products

  acts_as_nested_set
end
