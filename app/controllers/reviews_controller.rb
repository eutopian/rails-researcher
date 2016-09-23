class ReviewsController < ApplicationController
	def new
		@user = current_user
		@review = Review.new
	end

	def index
		@user = current_user
		@review = Review.new
	end

	def show
		@user = current_user
		@review = Review.find_by(id: params[:id])
		@article = Article.find_by(id: @review.article_id)
	end

	def create
		@article = Article.find_by(id: params[:article_id])
		@review = Review.create(review_params)
		redirect_to article_path(@article)
	end

	# def update
	# 	@user = current_user
	# 	@article = Article.find_by(id: params[:id])
	# 	if @article.update(article_params)
	# 		redirect_to article_path(@article)
	# 	else
	# 		flash.now[:notice] = "Post can not be saved, please enter information."
	# 		render :update
	# 	end
	# end

	def destroy
		@user = current_user
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
