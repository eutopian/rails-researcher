class Article < ApplicationRecord
	belongs_to :author, :class_name => "User"
	belongs_to :topic
	has_many :reviews
	has_many :comments
	accepts_nested_attributes_for :topic, reject_if: :all_blank

	has_attached_file :document, :default_url => "/system/articles/documents/000/000/011/original/WITPdown.pdf"
 	validates_attachment :document, :content_type => { :content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document) }

 	def already_reviewed
 		if @user
 			Review.where("article_id = #{self.id}" && "reviewer_id = #{@user.id}")
 		end
 	end
end