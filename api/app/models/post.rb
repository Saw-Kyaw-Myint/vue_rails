class Post < ApplicationRecord
  has_many :category_posts, dependent: :destroy
  has_many :categories, through:  :category_posts
  belongs_to :user

  mount_uploader :image, AvatarUploader
  validates  :title,presence: true
  validates  :user_id,presence: true
  validates  :image,presence: true
  validates  :description,presence:true

  scope  :search_by_title,->(search)  {where('title LIKE ?', "%#{search}%")}
  def self.latest_three_data(limit = 3)
    order(created_at: :desc).limit(limit)
  end
end
