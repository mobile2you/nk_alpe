# frozen_string_literal: true

RSpec.describe(NkAlpe::Api::User::Session, type: :api) do
  let(:session) { NkAlpe::Api::User::Session }

  describe '#create' do
    context 'correct params are passed' do
      let(:user) { attributes_for(:user_credentials) }

      it 'has status' do
        response = session.create(user)

        expect(response[:status]).to eq(200)
      end

      it 'has response with keys' do
        response = session.create(user)

        expect(response[:tokens][:accessToken]).to(be_present)
        expect(response[:tokens][:refreshToken]).to(be_present)
        expect(response[:usuario]).to(be_present)
      end
    end

    context 'incorrect params are passed' do
      let(:user) { attributes_for(:user_invalid_credentials) }

      it 'has status' do
        response = session.create(user)

        expect(response[:status]).to eq(401)
      end

      it 'has response with key & text' do
        response = session.create(user)

        expect(response[:message]).to eq('invalid-credentials')
      end
    end
  end
end
