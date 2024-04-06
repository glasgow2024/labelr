class AddLabelTypeToImpression < ActiveRecord::Migration[7.0]
  def change
    reversible do |change|
      change.down do
        remove_column :impressions, :label_type

        execute <<-SQL
          DROP TYPE label_type_enum;
        SQL
      end
      change.up do
        execute <<-SQL
          CREATE TYPE label_type_enum AS ENUM ('member', 'staff');
        SQL

        add_column :impressions, :label_type, :label_type_enum, default: 'member'
      end
    end
  end
end
