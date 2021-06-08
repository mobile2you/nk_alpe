# frozen_string_literal: true

RSpec.describe(NkAlpe::Request, type: :modules) do
  let(:new_request) { NkAlpe::Request.new }
  subject { NkAlpe::Request.new }

  describe '#define_headers' do
    it 'should return' do
      expect(subject.define_headers).to be_a(Hash)
    end

    it 'should set headers' do
      request = new_request

      request.define_headers do |headers|
        headers['HeadersAttr'] = 'foobar'
      end

      expect(request.headers['HeadersAttr']).to eq('foobar')
    end
  end

  describe '#bearer_token' do
    it 'should return' do
      request = new_request
      expect(request.bearer_token('test')).to eq('Bearer test')
    end

    it 'should set header' do
      request = new_request
      request.bearer_token('test')

      expect(request.headers['Authorization']).to(eq('Bearer test'))
    end
  end
end
