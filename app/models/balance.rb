class Balance < ApplicationRecord
  has_many :operations
  validates :user_id, presence: true
  validates :title, presence: true, format: { with: /[a-zA-Z0-9_.-]/ }
  validates :category, presence: true, format: { with: /[a-zA-Z0-9_.-]/ }
  validates :total, presence: true, format: { with: /[0-9]{4,6}/ }
end
