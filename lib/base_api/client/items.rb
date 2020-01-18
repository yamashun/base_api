module BaseApi
  class Client
    module Items
      def items(option = {})
        paginate('/1/items', option)
      end
    end
  end
end
