class CreateSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :steps do |t|
      t.references :order, null: false, foreign_key: true
      t.string :name
      t.datetime :date
      t.timestamps
    end
  end
end
