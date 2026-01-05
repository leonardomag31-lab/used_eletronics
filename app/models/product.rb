class Product < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :title, :description, :condition, presence: true
  validates :price, numericality: { greater_than: 0 }
end
