class AddPublicToDramas < ActiveRecord::Migration[6.1]
  def change
    add_column :dramas, :is_public, :boolean, default: false, null: false
  end
end
