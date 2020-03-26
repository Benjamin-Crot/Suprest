class AddQuantityToPricing < ActiveRecord::Migration[6.0]
  def change
    add_column :pricings, :quantity, :integer
  end
end
