class ChangeTypeRoleName < ActiveRecord::Migration[6.0]
  def change
    remove_column :roles, :type
    add_column :roles, :is_admin, :boolean, :default => false
  end
end
