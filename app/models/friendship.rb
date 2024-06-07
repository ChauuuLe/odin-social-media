class Friendship < ApplicationRecord
	after_create :create_inverse
  after_destroy :destroy_inverse

  belongs_to :user
  belongs_to :friend, class_name: 'User'

	validates :user,   presence: true
	validates :friend, presence: true, uniqueness: { scope: :user }
	
  validate :self_req

  private

  def create_inverse
    friend.friendships.create(friend: user)
  end

  def destroy_inverse
    friendship = friend.friendships.find_by(friend: user)
    if friendship 
      friendship.destroy
    end
  end

	private

	def self_req
    if user == friend
		  errors.add(:friend, "cannot be friend of yourself") 
    end
	end

end