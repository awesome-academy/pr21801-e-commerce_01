class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :products, dependent: :destroy
  has_many :children, class_name: Category.name, foreign_key: "parent_id",
    dependent: :destroy
  belongs_to :parent, class_name: Category.name, optional: true
  validates :name, presence: true, uniqueness: true,
    length: {maximum: Settings.categories.maximum}
  scope :all_category, -> {select(:id, :name, :slug).where(parent_id: nil)}
  scope :main_category, -> {select(:id, :name, :slug).where(parent_id: nil).limit(Settings.categories.limit)}
  scope :other_category, -> {select(:id, :name, :slug).where(parent_id: nil).offset(Settings.categories.limit)}
  scope :roots, -> parent_id {where(parent_id: parent_id)}
  scope :by_id, -> category_id {where(id: category_id)}
  scope :ordered_by_name, -> {order(name: :asc)}
  scope :search_by_name, -> name {where("name LIKE ? ", "%#{name}%") if name.present?}

  def descendents
    self.children | self.children.map(&:descendents).flatten
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
