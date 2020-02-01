module BaseApi
  class Client
    module Categories
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/categories/
      def categories
        get_call_api('/1/categories')
      end
    end
  end
end
