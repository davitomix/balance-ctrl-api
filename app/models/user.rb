class User < ApplicationRecord
  has_secure_password
  has_many :operations, dependent: :destroy
  has_many :balances

  validates :name, presence: true, format: { with: /[A-Z][a-zA-Z][^#&<>"~;$^%{}?]/ }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
