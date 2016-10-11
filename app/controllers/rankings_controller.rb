class RankingsController < ApplicationController
	def index
		@user_arry = User.most_articles
	end

	def show
	end
end
