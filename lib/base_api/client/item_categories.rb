module BaseApi
  class Client
    module ItemCategories
      # @param [Integer|String] item_id
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/item_categories/detail
      def item_categories_detail(item_id, &block)
        call_get_api("/1/item_categories/detail/#{item_id}", &block)
      end

      # @param [Integer|String] item_id
      # @param [Integer|String] category_id
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/item_categories/add
      def item_categories_add(item_id, category_id, &block)
        call_post_api('/1/item_categories/add', { item_id: item_id, category_id: category_id }, &block)
      end

      # @param [Integer|String] item_category_id
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/item_categories/delete
      def item_categories_delete(item_category_id, &block)
        call_post_api('/1/item_categories/delete', { item_category_id: item_category_id }, &block)
      end
    end
  end
end
