require 'rails_helper'

RSpec.describe Balance, type: :model do
  it { should have_many(:operations).dependent(:destroy) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:total) }
  it { should validate_presence_of(:category) }
end
