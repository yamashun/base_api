module BaseApi
  class Error < StandardError
    def initialize(response)
      @response = response
      super(build_error_message)
    end

    def response_status
      @response.code
    end

    def response_headers
      @response.headers
    end

    def response_body
      @response.parsed_response
    end

    private

    def build_error_message
      message = "#{response_status}: "
      message << "#{@response['error']} " if @response['error']
      message << "#{@response['error_description']}" if @response['error_description']
      message << " uri: #{@response.request.uri}"
      message
    end
  end

  class ClientError < Error; end

  class ServerError < Error; end
end
