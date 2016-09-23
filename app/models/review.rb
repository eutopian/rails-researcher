class Review < ApplicationRecord
	belongs_to :reviewer, :class_name => "User"
	belongs_to :article

	has_attached_file :document
 	validates_attachment :document, :content_type => { :content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }


end