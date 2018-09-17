class Feature < ApplicationRecord
  belongs_to :product

  validates :screen, presence: true
  validates :camera, presence: true
  validates :cpu, presence: true
  validates :ram, presence: true
  validates :rom, presence: true
  validates :pin, presence: true
end
