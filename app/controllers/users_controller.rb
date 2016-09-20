class UsersController < ApplicationController
	def index
		@current_user = User.find_by(id: params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			# byebug
			redirect_to user_path(@user)
		else
			redirect_to new_user_path
		end
	end

	def show
		@user = User.find(params[:id])
		@article = Article.new
	end

	private
	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :middle_name, :last_name, :email, :affiliation)
	end
end