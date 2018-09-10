class Comment < ApplicationRecord
  acts_as_tree order: "created_at DESC"

  belongs_to :user
  belongs_to :product

  delegate :name, to: :user, prefix: true

  validates :content, presence: true,
    length: { maximum: Settings.comments.content_max_length }
end
