require 'base_api/configurable'
require 'httparty'
require 'base_api/error'
require 'base_api/client/authorizations'
require 'base_api/client/users'
require 'base_api/client/items'
require 'base_api/client/categories'
require 'base_api/client/item_categories'
require 'base_api/client/orders'

module BaseApi
  # TODO: 責務でクラス分ける
  class Client
    include HTTParty
    include BaseApi::Configurable
    include BaseApi::Client::Authorizations
    include BaseApi::Client::Users
    include BaseApi::Client::Items
    include BaseApi::Client::Categories
    include BaseApi::Client::ItemCategories
    include BaseApi::Client::Orders

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

    def inspect
      inspected = super

      inspected.gsub! @code, '*******' if @code
      inspected.gsub! @access_token, "#{'*'*28}#{@access_token[28..-1]}" if @access_token
      inspected.gsub! @refresh_token, "#{'*'*28}#{@refresh_token[28..-1]}" if @refresh_token
      inspected.gsub! @client_secret, "#{'*'*28}#{@client_secret[28..-1]}" if @client_secret

      inspected
    end

    def fetch_next_page
      paginate(@last_page_args[:path], next_page_payload)
    end

    def reset_response
      @response = nil
      @last_page_args = nil
    end

    private

    def call_post_api(path, payload = {}, &callback)
      @response = self.class.post(path, { body: payload, headers: authorization_header })
      handle_response(&callback)
    end

    def call_get_api(path, payload = {}, &callback)
      @response = self.class.get(path, { query: payload, headers: authorization_header })
      handle_response(&callback)
    end

    def handle_response(&callback)
      check_status
      success(response, &callback)
    rescue => e
      error(e, &callback)
    end

    def authorization_header
      { Authorization: "Bearer #{access_token}" }
    end

    def paginate(path, payload = {})
      if different_path_request_called?(path)
        reset_response
      end

      if payload[:offset].nil?
        payload.merge!(offset: @offset)
      end
      if payload[:limit].nil?
        payload.merge!(limit: @limit)
      end

      @last_page_args = { path: path, payload: payload }

      call_get_api(path, payload)
    end

    def next_page_payload
      next_offset = @last_page_args[:payload][:offset] + @last_page_args[:payload][:limit]
      @last_page_args[:payload].merge(offset: next_offset)
    end

    def different_path_request_called?(path)
      @last_page_args.is_a?(Hash) && @last_page_args[:path] != path
    end

    def check_status
      if response.client_error?
        raise BaseApi::ClientError.new(response)
      elsif response.server_error?
        raise BaseApi::ServerError.new(response)
      end
    end

    def success(response, &block)
      block.call(response, nil) if block_given?
      response
    end

    def error(error, &block)
      if block_given?
        block.call(response, error)
        response
      else
        raise error
      end
    end
  end
end
