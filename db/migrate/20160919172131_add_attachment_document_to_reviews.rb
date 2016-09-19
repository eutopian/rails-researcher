class AddAttachmentDocumentToReviews < ActiveRecord::Migration
  def self.up
    change_table :reviews do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :reviews, :document
  end
end
