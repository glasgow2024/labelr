class CreateImpressions < ActiveRecord::Migration[7.0]
  def change
    create_table :impressions, id: :uuid do |t|
      t.integer :registrant_id
      t.uuid :user_id
      t.string :user_name, limit: 500
      t.datetime :date_printed
      t.jsonb :label_used

      t.integer :lock_version
      t.timestamps
    end
  end
end
