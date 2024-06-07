class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    friends_ids = current_user.friends.pluck(:id)
    @posts = Post.where(author_id: [current_user.id] + friends_ids).page(params[:page]).per(10)
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id]) 
    @user_liked = @post.likes.exists?(author_id: current_user.id)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post created"
      redirect_to posts_path
    else
      flash[:alert] = "Unable to create post"
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "Post deleted"
      redirect_to posts_path
    else
      flash[:alert] = "Failed to destroy post"
      redirect_to post_path(@post)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
