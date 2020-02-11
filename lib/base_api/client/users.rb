module BaseApi
  class Client
    module Users
      def users_me(&block)
        call_get_api('/1/users/me', {}, &block)
      end
    end
  end
end
