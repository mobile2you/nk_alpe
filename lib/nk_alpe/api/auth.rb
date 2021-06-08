# frozen_string_literal: true

class NkAlpe
  module Api
    class Auth < Base
      SIGN_IN_ENDPT = '/fix/alpe/stark/api/signin'

      class << self
        def session(body)
          url = "#{auth_url}#{SIGN_IN_ENDPT}"

          request.post(url, body)
        end
      end
    end
  end
end
