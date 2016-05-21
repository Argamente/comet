class AddAccountIdToUserAccount < ActiveRecord::Migration
  def change
    add_column :user_accounts, :account_id, :integer
  end
end
