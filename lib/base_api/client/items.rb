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
    end
  end
end
