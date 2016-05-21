class CreatePersonJoinedProjects < ActiveRecord::Migration
  def change
    create_table :person_joined_projects do |t|
      t.integer :project_id
      t.integer :account_id

      t.timestamps null: false
    end
  end
end
