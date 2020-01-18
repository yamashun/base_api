module BaseApi
  module Configurable
    attr_accessor :client_id, :client_secret, :code, :access_token, :refresh_token,
                  :per_page, :offset, :redirect_uri

    class << self
      def keys
        @keys ||= [
          :client_id,
          :client_secret,
          :code,
          :access_token,
          :refresh_token,
          :per_page,
          :offset,
          :redirect_uri
        ]
      end
    end

    def configure
      yield self
    end

    # Reset configuration options to default values
    def reset!
      BaseApi::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", BaseApi::Default.options[key])
      end
      self
    end

    private

    def options
      Hash[BaseApi::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end
  end
end
