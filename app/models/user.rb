class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  has_many :likes
  has_many :ratings
  has_many :comments
  has_many :orders

  validates_presence_of :name
end
