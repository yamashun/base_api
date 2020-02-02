module BaseApi
  class Client
    module Users
      def users_me
        call_get_api('/1/users/me', {})
      end
    end
  end
end
