class AddEducationIdToEducations < ActiveRecord::Migration
  def change
    add_column :educations, :education_id, :integer
  end
end
