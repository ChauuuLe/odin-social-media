class Comment < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id
  belongs_to :post

  validates :content, presence: true, length: { maximum: 1000 }
end
