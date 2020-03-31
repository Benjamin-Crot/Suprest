class Order < ApplicationRecord
  belongs_to :account
  has_many :items, dependent: :destroy
  has_many :steps

end
