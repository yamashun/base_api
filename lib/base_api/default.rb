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
        ""
      end

      def client_secret
        ""
      end

      def code
        ""
      end

      def access_token
        ""
      end

      def refresh_token
        ""
      end

      def per_page
        ""
      end

      def offset
        ""
      end

      def redirect_uri
        ""
      end
    end
  end
end
