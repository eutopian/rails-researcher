class Comment < ApplicationRecord
	attr_accessor :comment_id, :enabled, :user_id
	
	belongs_to :article, optional: true
	belongs_to :user, optional: true
	belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :votes, as: :voteable

  validates :content, presence: true, length: { maximum: 25000 }
end
