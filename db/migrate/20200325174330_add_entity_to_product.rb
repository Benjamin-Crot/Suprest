class AddEntityToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :entity, :string
  end
end
