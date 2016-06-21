class AddAbilityUuidToUuids < ActiveRecord::Migration
  def change
    add_column :uuids, :ability_uuid, :integer
  end
end
