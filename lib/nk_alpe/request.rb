# frozen_string_literal: true

require 'active_support/core_ext/hash/indifferent_access'
require 'httparty'
require 'json'
require 'uri'

class NkAlpe
  class Request
    DEFAULT_HEADERS = { 'Content-Type': 'application/json' }.freeze
    DEFAULT_ERROR_RESPONSE = { status: 500, message: 'Erro interno' }.freeze

    attr_accessor :opts, :headers

    def initialize(opts_headers = {}, opts = {})
      @headers = DEFAULT_HEADERS.merge(opts_headers)
      @opts = opts
    end

    def post(endpt, body, opts_headers = {})
      headers = self.headers.merge(opts_headers)

      body = encode_body(body, headers['Content-Type'])

      response = HTTParty.post(endpt, body: body, headers: headers)

      generate_response(response)
    end

    def get(endpt, opts_headers = {})
      headers = self.headers.merge(opts_headers)

      response = HTTParty.get(endpt, headers: headers)

      generate_response(response)
    end

    # @returns [String] returns bearer token
    def bearer_token(token)
      headers['Authorization'] = "Bearer #{token}"
    end

    # Passing a block, define multiple headers attributes
    #
    # @returns [Hash] returns a Hash representing the request's headers
    def define_headers
      yield headers if block_given?

      headers
    end

    private

    def generate_response(request)
      response = request.parsed_response.blank? ? {} : request.parsed_response

      # Convert response to Hash and add http status on response
      normalize_response(response, request.code)
    rescue StandardError
      DEFAULT_ERROR_RESPONSE
    end

    # Based on the Content Type of the request, encode body
    #
    # @returns [Object]
    def encode_body(body, content_type)
      case content_type
      when 'application/x-www-form-urlencoded'
        URI.encode_www_form(body)
      else
        body.to_json
      end
    end

    # Base on the response type, handle situation
    # Also, add http status in case is not set
    #
    # @returns [Hash]
    def normalize_response(response, http_status)
      case response
      when Hash
        response[:status] = http_status
        response.with_indifferent_access
      when String
        response_json = {}.with_indifferent_access
        response_json[:status] = http_status
        response_json[:message] = response
        response_json
      else
        response_hash = {}.with_indifferent_access
        response_hash[:status] = http_status
        response_hash[:message] = response
        response_hash
      end
    end
  end
end
