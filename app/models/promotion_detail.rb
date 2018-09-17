class PromotionDetail < ApplicationRecord
  belongs_to :product
  belongs_to :promotion

  validate :not_overlap

  scope :overlaps, ->(start_date, end_date) do
    where "((start_date <= ?) and (end_date >= ?))", end_date, start_date
  end

  def overlaps?
    overlaps.exists?
  end

  def overlaps
    siblings.overlaps start_date, end_date
  end

  def not_overlap
    errors.add(:key, "overlap") if overlaps?
  end

  def siblings
    product.promotion_details.where("id != ?", id || -1)
  end
end
