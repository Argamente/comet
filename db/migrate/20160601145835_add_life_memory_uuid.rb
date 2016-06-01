class AddLifeMemoryUuid < ActiveRecord::Migration
  def change
    add_column :life_memories, :life_memory_uuid, :integer
  end
end
