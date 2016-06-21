class AddAbilityIdToAbility < ActiveRecord::Migration
  def change
    add_column :abilities, :ability_id, :integer
  end
end
