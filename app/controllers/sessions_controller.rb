class SessionsController < ApplicationController
	def create
	  if auth = request.env["omniauth.auth"]
	  	@user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
      session[:user_id] = @user.id
	  	redirect_to user_path(@user), :notice => "Signed in!"
		else 
  		@user = User.find_by(username: params[:username])
  		if @user.authenticate(params[:password])
  	  	session[:user_id] = @user.id
  	  	redirect_to user_path(@user), :notice => "Signed In Successfully!"
  		else
  	  	redirect_to root_path, :notice => "Invalid Username or Password"
  		end
  	end
  end

  def new
  	@user = User.new
 	end

	def destroy
  	session[:user_id] = nil
  	redirect_to root_url, :notice => "Signed Out!"
	end
end