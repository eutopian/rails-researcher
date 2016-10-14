class AddDefaultValueToLike2 < ActiveRecord::Migration[5.0]
  def change
  	change_column :likes, :like, :boolean, :null => true
  end
end
