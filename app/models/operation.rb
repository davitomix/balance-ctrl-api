class Operation < ApplicationRecord
  belongs_to :balance
  validates_presence_of :title, :type
end
