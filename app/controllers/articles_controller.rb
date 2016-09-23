class ArticlesController < ApplicationController
	include ArticlesHelper
	def new
		@user = current_user
		@article = Article.new
	end

	def show
		@user = current_user
		@article = Article.find_by(id: params[:id])
		@comment = @article.comments.build
		@review = get_review_to_delete
	end

	def create
		@article = Article.new(article_params)
		@user = current_user
		@article.author_id = @user.id
		@article.save
		redirect_to user_path(@user)
	end

	def update
		@user = current_user
		@article = Article.find_by(id: params[:id])
		if @article.update(article_params)
			redirect_to article_path(@article)
		else
			flash.now[:notice] = "Article can not be saved, please enter information."
			render :update
		end
	end

	def destroy
		@user = current_user
		article = Article.find_by(id: params[:id])
		article.delete
		redirect_to user_path(@user)
	end

	private
	def article_params
		params.require(:article).permit(:title, :author_id, :topic_id, :document, :topic_attributes => [:name])
	end
end
