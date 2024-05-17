class AddProductIdAndNameToImpression < ActiveRecord::Migration[7.0]
  def change
    add_column :impressions, :product_id, :integer
    add_column :impressions, :product_list_name, :string
  end
end
