class CreateDramas < ActiveRecord::Migration[6.1]
  def change
    create_table :dramas do |t|
      t.string :title
      t.string :genre
      t.text :description
      t.string :mood
      t.string :scene

      t.timestamps
    end
  end
end
