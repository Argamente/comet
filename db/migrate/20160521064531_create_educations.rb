class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.integer :account_id
      t.string :school_name
      t.datetime :start_date
      t.datetime :end_date
      t.string :degree
      t.string :major

      t.timestamps null: false
    end
  end
end
