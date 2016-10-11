class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :likeable_id
      t.string :likeable_type
      t.boolean :like
      t.integer :user_id

      t.timestamps
    end
  end
end
