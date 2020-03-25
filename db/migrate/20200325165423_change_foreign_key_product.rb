class ChangeForeignKeyProduct < ActiveRecord::Migration[6.0]
  def change
    remove_reference :products, :supplier, foreign_key: true
    add_reference :products, :account, foreign_key: true
  end
end
