class AddWatchedOnToDramas < ActiveRecord::Migration[6.1]
  def change
    add_column :dramas, :watched_on, :date
  end
end
