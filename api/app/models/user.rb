class User < ApplicationRecord
  has_secure_password
  attr_accessor :password_confirmation
  # mount_uploader :avatar, AvatarUploader
  validates :name, presence: { message: "Name can't be blank" }
  validates :email, presence: { message: "Email can't be blank" },
                    uniqueness: { message: "Email has already been taken" },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "Email format is invalid" }
  validates :password, presence: { message: "Password can't be blank" },
                      length: { minimum: 6, maximum: 12, message: "Password must be between 6 and 12 characters long" }
validates :password_confirmation, presence: { message: "Password confirmation can't be blank" }, if: -> { password.present? }
end
