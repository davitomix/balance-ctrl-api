class User < ApplicationRecord
  has_secure_password
  has_many :operations, dependent: :destroy, foreign_key: :user_id
  has_many :balances, foreign_key: :user_id
  validates_presence_of :name, :email, :password_digest
end
