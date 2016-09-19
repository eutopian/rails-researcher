class SessionsController < ApplicationController
	# def create
	#   auth = request.env["omniauth.auth"]
	#   user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
	#   session[:user_id] = user.id
	#   redirect_to root_url, :notice => "Signed in!"
	# end

	def create
  	@user = User.find_by(username: params[:user][:username])
  	if @user.authenticate(params[:user][:password])
  	  session[:user_id] = @user.id
  	  redirect_to user_path(@user)
  	else
  	  redirect_to root_path
  	end
  end

  def new
  	@user = User.new
 	end

	def destroy
  	session[:user_id] = nil
  	redirect_to root_url, :notice => "Signed out!"
	end
end