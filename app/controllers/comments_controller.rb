class CommentsController < ApplicationController
	def new
		@comment = Comment.new
	end

	def create
		@post = Post.find(params[:post_id])
		@topic = @post.topic_id
		@comment = @post.comments.build(comment_params)
		@comment.user = current_user
		authorize @comment
		if @comment.save
			flash[:notice] = "Success commented."
			redirect_to topic_post_path(@topic, @post)
		else
			flash[:error] = "error saving the comments."
			redirect_to topic_post_path(@topic, @post)
		end

	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = Comment.find(params[:id])
		@topic = @post.topic_id
		authorize @comment
		if @comment.destroy
			flash[:notice] = "Comment is deleted."
			# redirect_to topic_post_path(@topic, @post), notice: 'Comment is deleted.'
		else
			flash[:error] = "Error deleting comment."
			# redirect_to topic_post_path(@topoic, @post)
		end

		respond_to do |format|
			format.html
			format.js
		end
	end

	def show
    	@post = Post.find(params[:id])
    	@topic = Topic.find(params[:topic_id])
    	@comments = @post.comments
    	authorize @post
    end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end

end
