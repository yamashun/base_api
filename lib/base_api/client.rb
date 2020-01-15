require 'base_api/configurable'
require 'httparty'

module BaseApi
  class Client
    include HTTParty
    include BaseApi::Configurable

    base_uri 'https://api.thebase.in'

    attr_accessor :client_id, :client_secret, :code, :access_token, :refresh_token,
                  :offset, :response

    def initialize(options = {})
      BaseApi::Configurable.keys.each do |key|
        value = options.key?(key) ? options[key] : BaseApi.instance_variable_get(:"@#{key}")
        instance_variable_set(:"@#{key}", value)
      end

      yield(self) if block_given?
    end
  end
end
