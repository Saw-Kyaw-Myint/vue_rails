class Post < ApplicationRecord
  has_many :category_posts
  has_many :categories, through:  :category_posts

  mount_uploader :image, AvatarUploader
  validates  :title,presence: true
  validates  :category_id,presence: true
  validates  :image,presence: true
  validates  :description,presence:true
end
