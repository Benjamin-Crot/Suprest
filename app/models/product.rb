class Product < ApplicationRecord
  belongs_to :account

  validates :name, presence: true
  validates :description, presence: true
  validates :stock, presence: true

  has_one_attached :photo

end
