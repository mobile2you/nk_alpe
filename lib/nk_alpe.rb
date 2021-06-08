# frozen_string_literal: true

require_relative 'nk_alpe/version'
require_relative 'nk_alpe/config'
require_relative 'nk_alpe/errors'
require_relative 'nk_alpe/constants'
require_relative 'nk_alpe/request'
require_relative 'nk_alpe/api'

module NkAlpe
  class << self
    # Returns the global configurations for these module
    #
    # @return [NkAlpe::Config]
    def config
      @config ||= settings
    end

    # Sets the global configurations
    # We can set the configurations in the following way:
    #
    #   NkAlpe.settings do |config|
    #     config.foo = bar
    #
    #   end
    # If a config or a config's attribute was not set,
    # default setting will be used if exist
    #
    # @return [NkAlpe::Config]
    def settings
      configuration = Config.instance

      yield configuration if block_given?

      @config = configuration
    end
  end
end
