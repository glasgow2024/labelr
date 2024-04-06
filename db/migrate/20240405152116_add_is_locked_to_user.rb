class AddIsLockedToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_locked, :boolean, default: false, null: false
  end
end
