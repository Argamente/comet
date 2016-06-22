class ChangeWorkExperienceDataModel < ActiveRecord::Migration
  def change
    add_column :work_experiences, :group_id, :integer
    add_column :work_experiences, :work_id, :integer
    change_column :work_experiences, :start_date, :integer
    change_column :work_experiences, :end_date, :integer
  end
end
