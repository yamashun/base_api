module BaseApi
  module Configurable
    attr_accessor :client_id, :client_secret, :code, :access_token, :refresh_token,
                  :per_page, :offset

    class << self
      def keys
        @keys ||= [
          :client_id,
          :client_secret,
          :code,
          :access_token,
          :refresh_token,
          :per_page,
          :offset
        ]
      end
    end

    def configure
      yield self
    end

    private

    def options
      Hash[BaseApi::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end
  end
end
