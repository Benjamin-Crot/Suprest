class ChangeAcceptedNameToOrder < ActiveRecord::Migration[6.0]
  def change
        rename_column :orders, :accepted?, :status
  end
end
