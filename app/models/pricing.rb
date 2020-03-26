class Pricing < ApplicationRecord
  belongs_to :product

  validates :amount_cents, presence: true
  validates :quantity, presence: true
end

