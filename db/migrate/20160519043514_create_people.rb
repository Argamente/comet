class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :account_id
      t.string :account_email
      t.integer :urlcode

      t.timestamps null: false
    end
  end
end
