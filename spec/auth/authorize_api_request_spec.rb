require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let(:user) { UserFactory.create(password: 'password', password_confirmation: 'password') }

  describe '#call' do
    context 'when valid request' do
      let(:valid_header) { { 'Authorization' => token_generator(user.id) } }

      it 'returns user object' do
        expect(
          described_class.new(valid_header)
            .call[:user]
        ).to eq(user)
      end
    end

    context 'when invalid request' do
      context 'when missing token' do
        it 'raises a MissingToken error' do
          expect { described_class.new({}).call }
            .to raise_error(ExceptionHandler::MissingToken, 'Missing token')
        end
      end

      context 'when invalid token' do
        it 'raises an InvalidToken error' do
          expect { described_class.new('Authorization' => token_generator(5)).call }
            .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
        end
      end

      context 'when token is expired' do
        let(:expired_header) { { 'Authorization' => expired_token_generator(user.id) } }

        it 'raises ExceptionHandler::ExpiredSignature error' do
          expect { described_class.new(expired_header).call }
            .to raise_error(
              ExceptionHandler::InvalidToken,
              /Signature has expired/
            )
        end
      end

      context 'fake token' do
        let(:fake_header) { { 'Authorization' => 'foobar' } }

        it 'handles JWT::DecodeError' do
          expect { described_class.new(fake_header).call }
            .to raise_error(
              ExceptionHandler::InvalidToken,
              /Not enough or too many segments/
            )
        end
      end
    end
  end
end
