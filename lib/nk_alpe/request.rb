# frozen_string_literal: true

require 'httparty'
require 'json'
require 'uri'

class NkAlpe
  class Request
    HEADER_DEFAULTS = { 'Content-Type': 'application/json' }.freeze
    DEFAULT_ERROR_RESPONSE = { status: 500, message: 'Erro interno' }.freeze

    attr_accessor :opts, :headers_default

    def initialize(default_headers = {}, opts = {})
      @headers_default = HEADER_DEFAULTS.merge(default_headers)
      @opts = opts
    end

    def post(endpt, body, headers = {})
      headers = headers_default.merge(headers)

      body = encode_body(body, headers['Content-Type'])

      request = HTTParty.post(endpt, body: body, headers: headers)

      generate_response(request)
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
        response
      when String
        response_json = {}
        response_json[:status] = http_status
        response_json[:message] = response
        response_json
      else
        response_hash = {}
        response_hash[:status] = http_status
        response_hash[:message] = response
        response_hash
      end
    end

    # Convert Hash into queryble string format
    #
    # @return [String]
    def to_query(hash)
      array_query = hash.each_with_object([]) do |(key, value), array|
        array << "#{key}=#{value}" unless value.nil?
      end
      array_query.empty? ? '' : "?#{array_query.join('&')}"
    end
  end
end
