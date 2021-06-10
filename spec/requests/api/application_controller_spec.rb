require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#health' do
    it 'returns ok' do
      get :health
      expect(response).to have_http_status(:ok)
    end
  end
end
