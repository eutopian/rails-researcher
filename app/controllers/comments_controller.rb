class CommentsController < ApplicationController
	before_action :find_commentable

	def index
		@comments = @commentable.comments
	end

	def new
		@comment = Comment.new
	end

	def show
		@comment = @commentable.comments.find_by(id: params[:id])
	end

	def create
		@comment = @commentable.comments.create(comment_params)
		@comment.user = current_user
		@comment.save
		if @commentable.instance_of?(Article)
			redirect_to article_path(@comment.commentable), notice: 'Your comment was successfully posted!'
		else 
			@article = Article.find_by(id: @comment.parent_id)
			redirect_to article_path(@article), notice: 'Your reply was successfully posted!'
		end
	end

	def edit
		@user = current_user
		@comment = @commentable.comments.find_by(id: params[:id])
	end

	def update
		@user = current_user
		@comment = @commentable.comments.find_by(id: params[:id])
		# @article = Article.find_by(id: @comment.article_id)
		@comment.update(comment_params)
		redirect_to article_path(@comment.commentable)
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
    else
    	@commentable = Comment.find_by(id: params[:comment][:commentable_id])
    	# @article = 
    end
 	end
end
