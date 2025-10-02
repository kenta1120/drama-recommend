class AddUserToDramas < ActiveRecord::Migration[6.1]
  def change
    add_reference :dramas, :user, foreign_key: true
  end
end
