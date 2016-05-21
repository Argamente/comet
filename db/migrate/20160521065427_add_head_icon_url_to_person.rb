class AddHeadIconUrlToPerson < ActiveRecord::Migration
  def change
    add_column :people, :head_icon_url, :string
  end
end
