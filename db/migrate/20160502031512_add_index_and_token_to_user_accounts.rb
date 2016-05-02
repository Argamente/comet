class AddIndexAndTokenToUserAccounts < ActiveRecord::Migration
  def change
    add_index :user_accounts, :email, unique: true
    add_column :user_accounts, :remember_token, :string
    add_index :user_accounts, :remember_token
  end
end
