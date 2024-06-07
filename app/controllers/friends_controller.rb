class FriendsController < ApplicationController

  def index
		@friends = current_user.friendships.all.page(params[:page]).per(10)
	end 
  
  def show 
    @friend = Friendship.find_by(user_id: current_user.id, friend_id: params[:friend_id])
  end

	def create
		@friendship = Friendship.new(user_id: current_user.id, friend_id: params[:friend_id])
		if @friendship.save
			flash[:notice] = "Friendship accepted"
			request = FriendRequest.find_by(user_id: current_user.id, friend_id: params[:friend_id])
			request.destroy
			redirect_to user_path(params[:friend_id])
		else
			flash[:notice] = "Can not accept request"
			redirect_to user_path(params[:friend_id])
      
		end
	end

	
	def destroy
		@friendship = Friendship.find_by(friend_id: params[:id], user_id: current_user.id)
		if @friendship.destroy
			flash[:notice] = "Friendship deleted"
			redirect_to users_path
		else
			flash[:notice] = "Unable to destroy friendship"
			redirect_to users_path
		end
	end


end
