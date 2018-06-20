class User < ApplicationRecord
  # encrypt password
  has_secure_password

  has_many :organizations, foreign_key: :created_by

  validates_presence_of :name, :email, :password_digest
end
