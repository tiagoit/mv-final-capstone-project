class CreateFavourites < ActiveRecord::Migration[6.0]
  def change
    create_table :favourites do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider_id, null: false, foreign_key: false
      t.timestamp
    end
    add_index :favourites, [:user_id, :provider_id], unique: true
  end
end
