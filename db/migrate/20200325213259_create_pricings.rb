class CreatePricings < ActiveRecord::Migration[6.0]
  def change
    create_table :pricings do |t|
      t.integer :amount_cents
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
