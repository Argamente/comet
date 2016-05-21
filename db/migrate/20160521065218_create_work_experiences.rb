class CreateWorkExperiences < ActiveRecord::Migration
  def change
    create_table :work_experiences do |t|
      t.integer :account_id
      t.string :company
      t.string :position
      t.string :duty
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
