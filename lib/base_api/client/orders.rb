module BaseApi
  class Client
    module Orders
      # Get orders
      #
      # @option params [Hash] option
      #   ex) { limit: 20, offset: 50 }
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/orders/
      def orders(option = {})
        paginate('/1/orders', option)
      end

      # Get a single order
      #
      # @param [String] unique_key
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/orders/detail
      def orders_detail(unique_key)
        call_get_api("/1/orders/detail/#{unique_key}", {})
      end
    end
  end
end
