# frozen_string_literal: true

RSpec.describe(NkAlpe::Api::Auth, type: :api) do
  let(:auth) { NkAlpe::Api::Auth }

  describe '#session' do
    context 'correct params are passed' do
      let(:user) { attributes_for(:user_credentials) }

      it 'has status' do
        response = auth.session(user)

        expect(response[:status]).to eq(200)
      end

      it 'has response with keys' do
        response = auth.session(user)

        expect(response[:tokens][:accessToken]).to(be_present)
        expect(response[:tokens][:refreshToken]).to(be_present)
        expect(response[:usuario]).to(be_present)
      end
    end

    context 'incorrect params are passed' do
      let(:user) { attributes_for(:user_invalid_credentials) }

      it 'has status' do
        response = auth.session(user)

        expect(response[:status]).to eq(401)
      end

      it 'has response with key & text' do
        response = auth.session(user)

        expect(response[:message]).to eq('invalid-credentials')
      end
    end
  end
end
