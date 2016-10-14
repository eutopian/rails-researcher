class AddDefaultValueToLike < ActiveRecord::Migration[5.0]
  def change
  	change_column_default(:likes, :like, nil)
  end
end
