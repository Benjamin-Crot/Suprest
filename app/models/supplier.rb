class Supplier < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy
  validates :name, presence: true
  validates :address, presence: true
end
