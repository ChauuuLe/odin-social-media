class LikesController < ApplicationController
  before_action :authenticate_user!


  def create
    @post = Post.find(params[:id])
    @like = @post.likes.new(author: current_user)

    if @like.save
      flash[:notice] = "Post liked."
    else
      flash[:alert] = "Unable to like post."
    end
    redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:id])
    @like = @post.likes.find_by(author: current_user)

    if @like.destroy
      flash[:notice] = "Like removed."
    else
      flash[:alert] = "Unable to remove like."
    end
    redirect_to request.referer
  end

  
end
