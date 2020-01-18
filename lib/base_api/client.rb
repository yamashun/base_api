require 'base_api/configurable'
require 'httparty'
require 'base_api/client/authorizations'
require 'base_api/client/items'

module BaseApi
  class Client
    include HTTParty
    include BaseApi::Configurable
    include BaseApi::Client::Authorizations
    include BaseApi::Client::Items

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

    def paginate(path, payload = {})
      if defined?(@last_page_args) && @last_page_args[:path] != path
        reset_response
      end

      if payload[:offset].nil?
        payload.merge!(offset: @offset)
      end
      if payload[:limit].nil?
        payload.merge!(limit: @limit)
      end

      @last_page_args = { path: path, payload: payload }

      get_call_api(path, payload)
    end

    def next_page_payload
      next_offset = @last_page_args[:payload][:offset] + @last_page_args[:payload][:limit]
      @last_page_args[:payload].merge(offset: next_offset)
    end
  end
end
