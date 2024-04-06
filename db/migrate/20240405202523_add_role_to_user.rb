class AddRoleToUser < ActiveRecord::Migration[7.0]
  def change
    reversible do |change|
      change.down do
        remove_column :users, :role

        execute <<-SQL
          DROP TYPE user_role_enum;
        SQL
      end
      change.up do
        execute <<-SQL
          CREATE TYPE user_role_enum AS ENUM ('staff', 'admin');
        SQL

        add_column :users, :role, :user_role_enum, default: 'staff'
      end
    end
  end
end
