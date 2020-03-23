class Product < ApplicationRecord
  belongs_to :supplier

  validates :name, presence: true
  validates :description, presence: true
  validates :stock, presence: true
end
