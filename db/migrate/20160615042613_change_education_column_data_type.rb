class ChangeEducationColumnDataType < ActiveRecord::Migration
  def change
    change_column :educations, :start_date, :integer
    change_column :educations, :end_date, :integer
  end
end
