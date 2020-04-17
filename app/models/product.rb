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

  acts_as_taggable_on :categories
  $categories = [ "Légume", "Fruit", "Viande", "Poisson", "Autre" ]

  # acts_as_taggable_on :entities
  # $entities = [ "gramme", "kilogramme", "centilitre", "litre", "pièce" ]


  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:name, :entity],
    associated_against: {
      categories: [:name],
    },
    using: {
      tsearch: {any_word: true}
    }

  pg_search_scope :category_search,
    against: [:name],
    associated_against: {
      categories: [:name],
    },
    using: {
      tsearch: {any_word: true}
    }

  def self.category(query)
    if query.flatten.reject(&:blank?).present?
      category_search(query)
    else
      # No query? Return all records, newest first.
      order("created_at DESC")
    end
  end

  pg_search_scope :entity_search,
    against: [:entity],
    using: {
      tsearch: {any_word: true}
    }

  def self.entity(query)
    if query.flatten.reject(&:blank?).present?
      entity_search(query)
    else
      # No query? Return all records, newest first.
      order("created_at DESC")
    end
  end

end
