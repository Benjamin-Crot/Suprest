class AddSupplierIdToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :supplier, :integer
  end
end
