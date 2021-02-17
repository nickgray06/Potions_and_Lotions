class CreateSorcerersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :sorcerers do |t|
      t.string :name
      t.string :skill
    end
  end
end
