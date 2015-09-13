class PostsController < ApplicationController
 # def index
 #    @posts = Post.all
 #  	#@posts = Post.ordered_by_reverse_created_at.all
 #    authorize @posts
 # end

 def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post
 end

 def create    
     @topic = Topic.find(params[:topic_id])
     @post = Post.new(post_params)
     @post.user = current_user
     @post.topic = @topic
    authorize @post
    if @post.save
      @post.create_vote
       flash[:notice] = "Post was saved."
       redirect_to [@topic, @post]
    else
       flash[:error] = "There was an error saving the post. Please try again."
       render :new
    end
 end

 def show
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    @comments = @post.comments
    authorize @post
 end
  
 def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
 end

 def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
    if @post.update_attributes(post_params)
       flash[:notice] = "Post was updated."
       redirect_to [@topic, @post]
    else
       flash[:error] = "There was an error saving the post. Please try again."
       render :edit
    end
 end

 def destroy
  @post = Post.find(params[:id])
  @topic = Topic.find(params[:topic_id])
  authorize @post
  if @post.destroy
    redirect_to @topic, notice: "\"#{@post.title}\" is deleted."
  else
    flash[:error] = "Error deleting the post"
    redirect_to :show
  end
 end

 private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
