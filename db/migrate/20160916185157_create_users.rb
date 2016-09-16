class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username, default: "", null: false
      t.string :email, default: "", null: false
      t.string :password_digest
      t.integer :article_id
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :affiliation
      t.boolean :reviewer
      t.integer :role
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.timestamps
    end
  end
end
