class UsersController < ApplicationController
	before_action :authenticate_user, only: [:index, :show, :edit, :update]

	def index
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to user_path(@user)
		else
			flash[:notice] = "Please make sure all fields are filled before pressing submit"
			redirect_to new_user_path
		end
	end

	def show
		@article = Article.new
		if @user
			render :show
		else
			redirect_to "/signin"
		end
	end

	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to user_path(@user), :notice => "Successfully updated your information"
		else
			flash[:notice] = "Let's try that again"
			render :edit
		end
	end

	private
	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :middle_name, :last_name, :email, :affiliation, :reviewer)
	end
end