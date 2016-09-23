class ReviewsController < ApplicationController
	before_action :authenticate_user

	def new
		@review = Review.new
	end

	def index
		@review = Review.new
	end

	def show
		@review = Review.find_by(id: params[:id])
		@article = Article.find_by(id: @review.article_id)
	end

	def create
		@article = Article.find_by(id: params[:article_id])
		@review = Review.create(review_params)
		redirect_to article_path(@article)
	end

	def destroy
		@review = Review.find_by(id: params[:id])
		@article = Article.find_by(id: params[:article_id])
		@review.destroy
		redirect_to article_path(@article)
	end

	private
	def review_params
		params.require(:review).permit(:reviewer_id, :document, :article_id)
	end
end
