class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id
  
  has_many :likes, dependent: :destroy, foreign_key: :post_id
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: {maximum: 100}
  validates :content, presence: true, length: {maximum: 1000}
end
