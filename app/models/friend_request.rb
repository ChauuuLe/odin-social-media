class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validates :user,   presence: true
	validates :friend, presence: true, uniqueness: { scope: :user }
  validate :self_req

	private

	def self_req
    if user == friend
		  errors.add(:friend, "cannot send to yourself") 
    end
	end
end
