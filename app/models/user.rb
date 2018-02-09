require 'bcrypt'
class User < ApplicationRecord
  include BCrypt
  # Encrypted Passwords
  has_secure_password

  #Model Associations
  has_many :todos, foreign_key: :created_by

  #Validations
  validates :name, :email, :password_digest, presence: true
  validates :email, uniqueness: true
end
