class AddMinMaxQuantityToPricing < ActiveRecord::Migration[6.0]
  def change
    add_column :pricings, :max_quantity, :integer
    rename_column :pricings, :quantity, :min_quantity
  end
end
