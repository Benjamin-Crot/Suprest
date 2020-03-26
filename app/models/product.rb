class Product < ApplicationRecord
  belongs_to :account
  has_many :pricing, dependent: :destroy
  has_many :items, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :stock, presence: true
  validates :category, presence: true
  validates_inclusion_of :entity, in: [ "gramme", "kilogramme", "centilitre", "litre", "pièce" ]
  has_one_attached :photo

end
