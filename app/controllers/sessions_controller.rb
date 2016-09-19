class SessionsController < ApplicationController
	# def create
	#   auth = request.env["omniauth.auth"]
	#   user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
	#   session[:user_id] = user.id
	#   redirect_to root_url, :notice => "Signed in!"
	# end

	def create
  	@user = User.find_by(name: params[:user][:name])
  	if @user.authenticate(params[:user][:password])
  	  session[:user_id] = @user.id
  	  redirect_to @user
  	else
  	  redirect_to '/'
  	end
  end

	def destroy
  	session[:user_id] = nil
  	redirect_to root_url, :notice => "Signed out!"
	end
end