class ChangeItemModel < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :price
    remove_column :items, :quantity
    add_column :items, :price, :decimal
    add_column :items, :quantity, :integer
  end
end
