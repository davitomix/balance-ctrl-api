require 'rails_helper'

RSpec.describe Balance, type: :model do
  describe 'associations' do
    it { should have_many(:operations) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:total) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:user_id) }
  end
end
