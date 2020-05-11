class Order < ApplicationRecord
  belongs_to :account
  has_many :items, dependent: :destroy
  has_many :steps

  scope :filter_by_step, -> (step) {
    joins(:steps)
    .where('steps.created_at = (SELECT MAX(steps.created_at) FROM steps WHERE steps.order_id = orders.id)')
    .where('steps.name = ?', step)
    .group('orders.id')
  }

end
