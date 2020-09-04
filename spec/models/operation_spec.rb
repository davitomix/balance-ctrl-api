require 'rails_helper'

RSpec.describe Operation, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:balance_id) }
end
