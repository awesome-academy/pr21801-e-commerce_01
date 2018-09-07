class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :content, presence: true,
    length: { maximum: Settings.comments.content_max_length }
end
