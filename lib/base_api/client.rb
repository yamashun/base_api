require 'base_api/configurable'
require 'httparty'
require 'octokit/client/authorizations'
require 'octokit/client/items'

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

    def fetch_next_page
      paginate(@last_page_args[:path], next_page_payload)
    end

    def reset_response
      @response = nil
      @@last_page_args = nil
    end

    private

    def post_call_api(path, payload = {})
      @response = self.class.post(path, { body: payload, headers: authorization_header })
    end

    def get_call_api(path, payload = {})
      @response = self.class.get(path, { query: payload, headers: authorization_header })
    end

    def authorization_header
      { Authorization: "Bearer #{access_token}" }
    end
  end
end
