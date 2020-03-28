class AddAcceptedToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :accepted?, :boolean, default: false
  end
end
