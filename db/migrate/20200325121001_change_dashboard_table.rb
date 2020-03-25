class ChangeDashboardTable < ActiveRecord::Migration[6.0]
  def change
    remove_reference :dashboards, :user, foreign_key: true
    add_reference :dashboards, :account, foreign_key: true
  end
end
