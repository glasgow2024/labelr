class EnableUuids < ActiveRecord::Migration[7.0]
  def up
    enable_extension 'pgcrypto'
  end
end
