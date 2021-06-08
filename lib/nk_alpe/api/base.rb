# frozen_string_literal: true

class NkAlpe
  module Api
    class Base
      class << self
        def new_request
          Request.new
        end

        def new_request_with_auth(token)
          request = new_request
          request.bearer_token(token)

          request
        end

        def base_url
          BASE_URL_HML
        end

        def auth_url
          AUTH_URL_HML
        end

        # @params hash_query [Hash, nil] optional
        # @return [String] returns generated url
        def generate_url(base, endpt, hash_query = nil)
          if hash_query.present?
            query = generate_query(hash_query)

            "#{base}#{endpt}#{query}"
          else
            "#{base}#{endpt}"
          end
        end

        private

        # Convert Hash into queryble string format
        #
        # @return [String]
        def generate_query(hash)
          array_query = hash.each_with_object([]) do |(key, value), array|
            array << "#{key}=#{value}" unless value.nil?
          end
          array_query.empty? ? '' : "?#{array_query.join('&')}"
        end
      end
    end
  end
end
