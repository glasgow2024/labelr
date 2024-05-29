class MakeImpressionPolymorphic < ActiveRecord::Migration[7.0]
  def change
    # registrant_id to registable_id
    # add registable_type
    rename_column :impressions, :registrant_id, :registable_id
    add_column :impressions, :registable_type, :string, default: "Registration::Registrant"
  end
end
