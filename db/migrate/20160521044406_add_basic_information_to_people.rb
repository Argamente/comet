class AddBasicInformationToPeople < ActiveRecord::Migration
  # 添加基础信息到people表
  def change
    add_column :people, :name, :string        #姓名
    add_column :people, :gender, :boolean     #1是男，0是女
    add_column :people, :occupation, :string  #职业
    add_column :people, :birthday, :integer   #出生年月
    add_column :people, :location, :string    #居住地
  end
end
