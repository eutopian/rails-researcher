class AddTopicIdToArticle < ActiveRecord::Migration[5.0]
  def change
  	add_column :articles, :topic_id, :integer
  end
end
