# frozen_string_literal: true

class NkAlpe
  module Api
    class Base
      class << self
        def request(headers = {}, opts = {})
          Request.new(headers, opts)
        end

        def base_url
          BASE_URL_HML
        end

        def auth_url
          AUTH_URL_HML
        end
      end
    end
  end
end
