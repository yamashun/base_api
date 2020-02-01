module BaseApi
  class Client
    module ItemCategories
      # @param [Integer|String] item_id
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/item_categories/detail
      def item_categories_detail(item_id)
        get_call_api("/1/item_categories/detail/#{item_id}")
      end
    end
  end
end
