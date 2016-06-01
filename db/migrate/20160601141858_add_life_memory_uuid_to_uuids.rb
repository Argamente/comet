class AddLifeMemoryUuidToUuids < ActiveRecord::Migration
  def change
    add_column :uuids, :life_memory_uuid, :integer

  end
end
