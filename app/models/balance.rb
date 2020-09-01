class Balance < ApplicationRecord
  has_many :operations, dependent: :destroy
  validates_presence_of :user_id, :title, :total, :category
end
