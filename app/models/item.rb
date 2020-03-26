class Item < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :price, presence: true
  validates :quantity, presence: true
end
