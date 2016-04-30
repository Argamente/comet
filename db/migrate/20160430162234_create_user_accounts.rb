class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|
      t.string :email
      t.string :password
      t.string :action_code
      t.integer :code_timestamp
      t.integer :account_state
      t.string :phone
      t.string :qq_number
      t.string :wechat

      t.timestamps null: false
    end
  end
end
