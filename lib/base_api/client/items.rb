module BaseApi
  class Client
    module Items
      # @option params [Hash] option
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/
      def items(option = {})
        paginate('/1/items', option)
      end

      # @param [String] q: search word
      # @option params [Hash] option
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/search
      def items_search(q, option = {})
        paginate('/1/items/search', { q: q }.merge(option))
      end

      # @param [Integer | String] item_id
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/detail
      def items_detail(item_id)
        get_call_api("/1/items/detail/#{item_id}")
      end

      # @param [Hash] item
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/add
      def items_add(item)
        post_call_api('/1/items/add', item)
      end
    end
  end
end
