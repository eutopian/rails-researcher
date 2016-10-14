class LikesController < ApplicationController
	before_action :set_model

	def create
		Like.create_like(@model, current_user)
	end
	
	def dislike
		Like.create_dislike(@model, current_user)
	end
	
	def set_model
		@model=User.find_model(params[:id], params[:type])
	end

	def like_data
		like = Like.find(params[:id])
		render json: like.to_json(:include => [:user, :likeable])
	end
end