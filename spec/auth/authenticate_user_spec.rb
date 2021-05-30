require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) { UserFactory.create(password: 'password', password_confirmation: 'password') }

  describe '#call' do
    context 'when valid credentials' do
      it 'returns an auth token' do
        expect(
          described_class.new(
            user.email,
            user.password
          ).call
        ).not_to be_nil
      end
    end

    context 'when invalid credentials' do
      it 'raises an authentication error' do
        expect { described_class.new('foo', 'bar').call }
          .to raise_error(
            ExceptionHandler::AuthenticationError,
            /Invalid credentials/
          )
      end
    end
  end
end
