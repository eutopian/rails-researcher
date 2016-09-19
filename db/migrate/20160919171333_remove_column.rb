class RemoveColumn < ActiveRecord::Migration[5.0]
  def change
  	remove_column :users, :article_id
  end
end
