class CreateProjectComments < ActiveRecord::Migration
  def change
    create_table :project_comments do |t|
      t.integer :comment_id
      t.text :comment
      t.integer :project_id
      t.integer :parent_comment_id
      t.integer :account_id

      t.timestamps null: false
    end
  end
end
