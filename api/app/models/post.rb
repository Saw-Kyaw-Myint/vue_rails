class Post < ApplicationRecord
  mount_uploader :image, AvatarUploader
  validates  :title,presence: true
  validates  :category_id,presence: true
  validates  :image,presence: true
  validates  :description,presence:true
end
