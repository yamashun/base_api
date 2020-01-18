module BaseApi
  class Client
    module Authorizations
      def oauth_access_token(&block)
        post_call_api('/1/oauth/token', access_token_payload)
        if response.success?
          @access_token = response['access_token']
          @refresh_token = response['refresh_token']
        end

        if block_given?
          yield(response)
        end
        response
      end

      def oauth_refresh_token(&block)
        post_call_api('/1/oauth/token', refresh_token_payload)
        if response.success?
          @access_token = response['access_token']
          @refresh_token = response['refresh_token']
        end

        if block_given?
          yield(response)
        end
        response
      end

      private

      def access_token_payload
        {
          grant_type: 'authorization_code',
          client_id: client_id,
          client_secret: client_secret,
          code: code,
          redirect_uri: redirect_uri
        }
      end

      def refresh_token_payload
        {
          grant_type: 'refresh_token',
          client_id: client_id,
          client_secret: client_secret,
          refresh_token: refresh_token,
          redirect_uri: redirect_uri
        }
      end
    end
  end
end
