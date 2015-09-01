class CommentsController < ApplicationController
	def new
		@comment = Comment.new
	end

	def create
		@comment = current_user.comments.build(comment_params)
		@post = Post.find(params[:post_id])
		@comment.post = @post
		@topic = Topic.find(params[:topic_id])
		authorize @comment
		if @comment.save
			flash[:notice] = "Success commented."
			redirect_to topic_post_path(@topic, @post)
		else
			flash[:error] = "error saving the comments."
			redirect_to topic_post_path(@topic, @post)
		end

	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end

end
