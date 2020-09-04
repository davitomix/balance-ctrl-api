class Operation < ApplicationRecord
  belongs_to :user
  validates_presence_of :title, :status, :user_id, :balance_id
end
