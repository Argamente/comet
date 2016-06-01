class AddTagToLifeMemory < ActiveRecord::Migration
  def change
    add_column :life_memories, :tag, :integer
  end
end
