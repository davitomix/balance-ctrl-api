class Operation < ApplicationRecord
  belongs_to :user
  validates_presence_of :user_id, :balance_id
  validates :title, presence: true, format: { with: /[a-zA-Z0-9_.-]/ }
  validates :status, presence: true, format: { with: /[0-9]/ }
end
