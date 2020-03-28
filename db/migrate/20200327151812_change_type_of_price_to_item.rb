class ChangeTypeOfPriceToItem < ActiveRecord::Migration[6.0]
  def change
    change_column :items, :price, :integer
    rename_column :items, :price, :amount_cents
  end
end
