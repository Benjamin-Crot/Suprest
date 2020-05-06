class Step < ApplicationRecord
  belongs_to :order

  validates_inclusion_of :name, in: [ "Validée", "En cours de traitement", "En cours de livraison", "Livrée"]
end
