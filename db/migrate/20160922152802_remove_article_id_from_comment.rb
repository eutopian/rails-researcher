class RemoveArticleIdFromComment < ActiveRecord::Migration[5.0]
  def change
  	remove_column :comments, :article_id
  end
end
