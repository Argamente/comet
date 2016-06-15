class AddSomeUuiDtoUuid < ActiveRecord::Migration
  def change
    add_column :uuids, :project_uuid, :integer
    add_column :uuids, :comment_uuid, :integer
    add_column :uuids, :education_uuid, :integer
    add_column :uuids, :work_experience_uuid, :integer
  end
end
