class Product < ApplicationRecord
  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category

  validates :name, :price, :price_cents, :quantity, :category, presence: true
  
end
