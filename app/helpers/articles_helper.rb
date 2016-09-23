module ArticlesHelper
	def available_for_review
 		Review.where("article_id = #{@article.id}" && "reviewer_id = #{@user.id}").empty?
 	end

 	def get_review_to_delete
 		Review.where("article_id = #{@article.id}" && "reviewer_id = #{@user.id}").first if @user && @article
 	end
end