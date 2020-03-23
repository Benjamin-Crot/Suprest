class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :stock
      t.references :supplier, null: false, foreign_key: true
      t.timestamps
    end
  end
end
