class ChangePeopleInformationGenderType < ActiveRecord::Migration
  def change
    change_column :people, :gender, :integer     #1是男，0是女
  end
end
