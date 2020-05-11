class Step < ApplicationRecord
  belongs_to :order

  validates_inclusion_of :name, in: [ "Validée", "En cours de traitement", "En cours de livraison", "Livrée"]

  scope :latest_per_order, -> { order(:order_id, created_at: :desc).uniq{|t| t.order_id } }
  # scope :filter_by_step, -> (step) { where(name: step) }

  # scope :created_before, ->(time) { where("created_at < ?", time) }

end
