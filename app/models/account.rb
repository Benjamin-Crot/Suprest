class Account < ApplicationRecord
  has_many :users, through: :roles

  validates :name, presence: true
  validates :address, presence: true
  validates :category, presence: true
end
