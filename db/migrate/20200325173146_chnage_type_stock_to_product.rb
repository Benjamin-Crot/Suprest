class ChnageTypeStockToProduct < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :stock
    add_column :products, :stock, :integer
  end
end
