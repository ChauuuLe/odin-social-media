class CommentsController < ApplicationController
  

  def create
    @post = Post.find (params[:post_id])
    @comment = @post.comments.build (comment_params)
    @comment.author = current_user
    if @comment.save
      flash[:notice] = "Comment created."
      redirect_to post_path (@post)
    else
      flash[:alert] = "Failed create comment."
      render 'posts/show'
    end
  end

  def destroy
    @comment = Comment.find (params[:comment_id])
    @post = Post.find (params[:post_id])
    if @comment.destroy
      flash[:notice] = "Comment deleted"
      redirect_to post_path(@post)
    else
      flash[:notice] = "Failed to delete comment"
      render 'posts/show'
    end
  end

  private

  def comment_params 
    params.require(:comment).permit(:content)
  end
end
