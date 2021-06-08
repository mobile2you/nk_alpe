# frozen_string_literal: true

class NkAlpe
  module Api
    class Transaction < Base
      class << self
        def create(_user, body)
          endpoint = '/payment-order/api/v1/transfer-initiation'
          url = generate_url(base_url, endpoint)

          request = new_request_with_auth(token)

          request.post(url, body)
        end

        # Fetch transactions paginated
        # @note can be filter by transaction id
        #
        def fetch(_user, hash_query)
          endpoint = '/payment-order/api/v1/payment-transactions'
          url = generate_url(base_url, endpoint, hash_query)

          request = new_request_with_auth(token)

          request.get(url, body)
        end
      end
    end
  end
end
