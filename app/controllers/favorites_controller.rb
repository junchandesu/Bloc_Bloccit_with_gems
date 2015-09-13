class FavoritesController < ApplicationController

	def create
		post = Post.find(params[:post_id])
		favorite = current_user.favorites.build(post: post)
		authorize favorite

		if favorite.save
			redirect_to [post.topic, post], notice: "You have successfully favored this post."
		else
			flash[:error] = "Error saving this favorite."
			render :back
		end
	end

	def destroy
		post = Post.find(params[:post_id])
		favorite = post.favorites.find(params[:id])
		authorize favorite
		if favorite.destroy
			redirect_to [post.topic, post], notice: "You unfavared this post successfully."
		else
			flash[:error] = "Error unfavoring this post."
			redirect_to [post.topic, post]
		end
	end
end
