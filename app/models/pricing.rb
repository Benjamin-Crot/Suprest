class Pricing < ApplicationRecord
  belongs_to :product

  validates :amount_cents, presence: true
  validates :min_quantity, presence: true
  validates :max_quantity, presence: true
end

