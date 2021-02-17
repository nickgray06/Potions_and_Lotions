class CreateItemsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :ability
      t.integer :rarity
      t.integer :cast_cost
      t.integer :price
    end
  end
end
