module BaseApi
  class Client
    module Users
      def users_me
        get_call_api('/1/users/me', {})
      end
    end
  end
end
