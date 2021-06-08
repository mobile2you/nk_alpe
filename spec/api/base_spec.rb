# frozen_string_literal: true

RSpec.describe(NkAlpe::Api::Base, type: :api) do
  subject { NkAlpe::Api::Base }

  describe '#new_request' do
    it 'should return' do
      expect(subject.new_request_with_auth('test')).to be_a(NkAlpe::Request)
    end
  end

  describe '#new_request_with_auth' do
    it 'should return' do
      expect(subject.new_request_with_auth('test')).to be_a(NkAlpe::Request)
    end

    it 'should set header' do
      request = subject.new_request_with_auth('test')
      expect(request.headers['Authorization']).to(eq('Bearer test'))
    end
  end

  describe '#generate_url' do
    let(:base_url) { 'test.com' }
    let(:endpt) { '/api/test' }

    let(:url_without_query) { "#{base_url}#{endpt}" }

    let(:query_key) { 'foo' }
    let(:query_value) { 'bar' }
    let(:query) { { "#{query_key}": query_value } }

    let(:url_with_query) do
      "#{base_url}#{endpt}?#{query_key}=#{query_value}"
    end

    context 'when param hash_query passed' do
      it do
        expect(subject.generate_url(base_url,
                                    endpt,
                                    query)).to eq(url_with_query)
      end
    end

    context 'when param hash_query not passed' do
      it do
        expect(subject.generate_url(base_url, endpt)).to eq(url_without_query)
      end
    end
  end
end
