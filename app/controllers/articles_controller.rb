class ArticlesController < ApplicationController
	include ArticlesHelper
	before_action :authenticate_user

	def index
		redirect_to root_path
	end

	def new
		@article = Article.new
	end

	def show
		@article = Article.find_by(id: params[:id])
		@comment = @article.comments.build
		@review = get_review_to_delete
	end

	def create
		@article = Article.new(article_params)
		@article.author_id = @user.id
		@article.save
		redirect_to user_path(@user)
	end

	def edit
	end

	def update
		@article = Article.find_by(id: params[:id])
		if @article.update(article_params)
			redirect_to article_path(@article)
		else
			flash.now[:notice] = "Article can not be saved, please enter information."
			render :update
		end
	end

	def destroy
		article = Article.find_by(id: params[:id])
		article.delete
		redirect_to user_path(@user)
	end

	def body
    article = Article.find(params[:id])
    render json: ArticleSerializer.serialize(article)
  end

  def article_data
    article = Article.find(params[:id])
    render plain: ArticleSerializer.serialize(article)
  end

	private
	def article_params
		params.require(:article).permit(:title, :author_id, :topic_id, :document, :topic_attributes => [:name])
	end
end
