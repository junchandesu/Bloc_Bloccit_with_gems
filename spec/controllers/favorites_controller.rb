require 'rails_helper'

describe FavoritesController do 

	include TestFactories
	include Devise::TestHelpers

	before do
		@post = associated_post
		@user = authenticated_user
		sign_in @user
	end

	describe "#create" do 
		it "create a favorite for the current and specified  post" do 
			expect( @user.favorites.find_by_post_id(@post.id)).to be_nil
			post :create , { post.id: @post.id }
			expect( @userlfavorites.find_by_post_id(@post.id).not_to be_nil)
		end
	end

	describe "#destroy" do 
		it "destroy the favorites for the current user and post" do 
			favorite = @user.favorites.where(post: @post).create
			expect( @user.favorites.find_by_post_id(@post.id) ).not_to be_nil
			delete :destroy, { post_id: @post.id, id:favorite.id }
			expect{ @user.favorites.find_by_post_id(@post.id) }.to be_nil
		end
	end
 
end