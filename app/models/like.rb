class Like < ApplicationRecord
	belongs_to :likeable, polymorphic: true
	belongs_to :user, optional: true
	belongs_to :comment, optional: true
	belongs_to :article, optional: true
 
 	def self.create_like(model, current_user)
 		like = Like.find_or_initialize_by(:likeable=>model,:user_id=>current_user.id)
 		if like.like
 			like.destroy
 		else
 			like.like= true
 		like.save
 		end
 	end
 
 	def self.create_dislike(model, current_user)
 		like = Like.find_or_initialize_by(:likeable=>model,:user_id=>current_user.id)
 		if like.like==false
 			like.destroy
 		else
 			like.like= false
 		like.save
 		end
 	end
end