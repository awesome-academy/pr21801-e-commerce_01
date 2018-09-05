class Comment < ApplicationRecord
  acts_as_tree

  belongs_to :user
  belongs_to :product

  delegate :name, to: :user, prefix: true

  validates :content, presence: true,
    length: { maximum: Settings.comments.content_max_length }
end
