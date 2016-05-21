class CreateLifeMemories < ActiveRecord::Migration
  def change
    create_table :life_memories do |t|
      t.datetime :date
      t.text :content

      t.timestamps null: false
    end
  end
end
