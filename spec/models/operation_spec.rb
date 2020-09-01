require 'rails_helper'

RSpec.describe Operation, type: :model do
  it { should belong_to(:balance) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:type) }
end
