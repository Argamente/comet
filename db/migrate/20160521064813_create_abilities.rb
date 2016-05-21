class CreateAbilities < ActiveRecord::Migration
  def change
    create_table :abilities do |t|
      t.integer :account_id
      t.string :ability_name
      t.integer :ability_level

      t.timestamps null: false
    end
  end
end
