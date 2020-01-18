require 'base_api/configurable'

module BaseApi
  class Default
    class << self
      # Configuration options
      # @return [Hash]
      def options
        Hash[BaseApi::Configurable.keys.map{|key| [key, send(key)]}]
      end

      # TODO: set default values
      def client_id
        ENV['BASE_API_CLIENT_ID']
      end

      def client_secret
        ENV['BASE_API_CLIENT_SECRET']
      end

      def code
        ENV['BASE_API_CODE']
      end

      def access_token
        ENV['BASE_API_ACCESS_TOKEN']
      end

      def refresh_token
        ENV['BASE_API_REFRESH_TOKEN']
      end

      def per_page
        ENV.fetch("BASE_API_PER_PAGE") { 10 }
      end

      def offset
        ENV.fetch("BASE_API_OFFSET") { 0 }
      end

      def redirect_uri
        ENV['BASE_API_REDIRECT_URI']
      end
    end
  end
end
