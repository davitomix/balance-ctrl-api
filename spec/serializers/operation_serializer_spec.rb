require 'rails_helper'

describe OperationSerializer do
  let(:serializer) { described_class.new }

  describe '#serialize' do
    let(:user) { UserFactory.create(password: 'password', password_confirmation: 'password') }
    let(:operation) { OperationFactory.create(user: user, title: 'A title', status: 3) }

    let(:data) { serializer.serialize(operation) }

    it 'includes basic operation data' do
      expect(data).to include(operation.serializable_hash)
    end

    it 'includes title name' do
      expect(data['title']).to eq('A title')
    end

    it 'includes status' do
      expect(data['status']).to eq(3)
    end

    it 'includes user_id' do
      expect(data['user_id']).to eq(user.id)
    end
  end
end
