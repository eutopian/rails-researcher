class CommentsController < ApplicationController
	before_action :find_commentable
	before_action :authenticate_user, only: [:edit, :update]

	def index
		@comments = @commentable.comments
	end

	def new
		@comment = Comment.new
	end

	def show
		@comment = @commentable
	end

	def create
		if current_user
		@comment = @commentable.comments.create(comment_params)
		@comment.user = current_user
		@comment.save
		if @commentable.instance_of?(Article)
			redirect_to article_path(@comment.commentable), notice: 'Your comment was successfully posted!'
		else 
			@article = Article.find_by(id: @comment.parent_id)
			redirect_to article_path(@article), notice: 'Your reply was successfully posted!'
		end
		else
			redirect_to root_path, notice: 'Please sign in or create an account!'
		end
	end

	def edit
		@comment = @commentable
	end

	def update
		@comment = Comment.find_by(id: params[:id])
		@article = Article.find_by(id: @comment.parent_id)
		@comment.update(comment_params)
		redirect_to article_path(@article)
	end

	def destroy
		@comment = @commentable.comments.find_by(id: params[:id])
		@comment.delete
		redirect_to article_path(@comment.commentable)
	end

	private
	def comment_params
		params.require(:comment).permit(:content, :parent_id)
	end

	def find_commentable
		if params[:article_id]
    	@commentable = Article.find_by(id: params[:article_id])
    elsif params[:comment]
    	@commentable = Comment.find_by(id: params[:comment][:commentable_id])
    else
    	@commentable = Comment.find_by(id: params[:id])
    end
 	end
end
