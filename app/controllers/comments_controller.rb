class CommentsController < ApplicationController
	before_action :find_commentable
	# before_action :authenticate_user!

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
		redirect_to article_path(@comment.commentable), notice: 'Your comment was successfully posted!'
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
		params.require(:comment).permit(:content)
	end


	def find_commentable
		# resource, id = request.path.split('/')[1, 2]
  #   @commentable = resource.singularize.classify.constantize.find(id)

    @commentable = Comment.find_by(id: params[:comment_id]) if params[:comment_id]
    @commentable = Article.find_by(id: params[:article_id]) if params[:article_id]
 	end
end
