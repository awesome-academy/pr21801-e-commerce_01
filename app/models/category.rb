class Category < ApplicationRecord
  has_many :products
  has_many :children, class_name: "Category", foreign_key: "parent_id",
    dependent: :destroy
  belongs_to :parent, class_name: "Category", foreign_key: "parent_id"

  scope :roots, -> parent_id {where(parent_id: parent_id)}
  scope :by_id, -> category_id {where(id: category_id)}
end
