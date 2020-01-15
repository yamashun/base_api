require "base_api/version"
require "base_api/client"
require "base_api/configurable"
require "base_api/default"

module BaseApi
  class Error < StandardError; end
  # Your code goes here...

  class << self
    include BaseApi::Configurable

    def client
      @client = BaseApi::Client.new(options)
    end
  end
end
