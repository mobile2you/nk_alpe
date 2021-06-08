# frozen_string_literal: true

class NkAlpe
  module Api
    class Extract < Base
      class << self
        # Returns user's extract for a determined period
        # @note the balance is also returned according to the period.
        #
        def by_period(_user, hash_query)
          endpoint = '/coda/api/v1/account-statements'
          url = generate_url(base_url, endpoint, hash_query)

          request = new_request_with_auth(token)

          request.get(url)
        end
      end
    end
  end
end
