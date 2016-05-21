class AddAccountIdToLifeMemory < ActiveRecord::Migration
  def change
    add_column :life_memories, :account_id, :integer
  end
end
