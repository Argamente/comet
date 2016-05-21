class CreateUuids < ActiveRecord::Migration
  def change
    create_table :uuids do |t|
      t.integer :people_url_code

      t.timestamps null: false
    end
  end
end
