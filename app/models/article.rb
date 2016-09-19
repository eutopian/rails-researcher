class Article < ApplicationRecord
	belongs_to :author, :class_name => "User"
	belongs_to :topic
	has_many :reviews

	has_attached_file :document
 	validates_attachment :document, :content_type => { :content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }

end
