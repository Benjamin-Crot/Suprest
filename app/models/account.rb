class Account < ApplicationRecord
  has_many :roles
  has_many :users, through: :roles
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one :dashboard
  has_one_attached :photo
  validates :name, presence: true
  validates :address, presence: true
  validates :category, presence: true

end
