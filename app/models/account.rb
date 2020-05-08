class Account < ApplicationRecord
  has_many :roles
  has_many :users, through: :roles
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
  # has_one :dashboard
  validates :name, presence: true
  validates :address, presence: true
  validates_inclusion_of :category, presence: true, in: [ "Restaurateur", "Fournisseur" ]
  has_one_attached :photo

end
