module UsersHelper
	def authenticated_login
		@user && session[:user_id] == @user.id
	end
end