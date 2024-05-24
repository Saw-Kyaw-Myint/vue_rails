class Post < ApplicationRecord
  has_many :category_posts
  has_many :categories, through:  :category_posts
  belongs_to :user

  mount_uploader :image, AvatarUploader
  validates  :title,presence: true
  validates  :user_id,presence: true
  validates  :image,presence: true
  validates  :description,presence:true

  scope  :search_by_title,->(search)  {where('title LIKE ?', "%#{search}%")}
end
