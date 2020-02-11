module BaseApi
  class Client
    module Items
      # @option params [Hash] option
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/
      def items(option = {}, &block)
        paginate('/1/items', option, &block)
      end

      # @param [String] q: search word
      # @option params [Hash] option
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/search
      def items_search(q, option = {}, &block)
        paginate('/1/items/search', { q: q }.merge(option), &block)
      end

      # @param [Integer | String] item_id
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/detail
      def items_detail(item_id, &block)
        call_get_api("/1/items/detail/#{item_id}", &block)
      end

      # @param [Hash] item
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/add
      def items_add(item, &block)
        call_post_api('/1/items/add', item, &block)
      end

      # @param [Hash] item
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/edit
      def items_edit(item, &block)
        call_post_api('/1/items/edit', item, &block)
      end

      # @param [Integer|String] item_id
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/delete
      def items_delete(item_id, &block)
        call_post_api('/1/items/delete', { item_id: item_id }, &block)
      end

      # @param [Hash] item_image
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/add_image
      def items_add_image(item_image, &block)
        call_post_api('/1/items/add_image', item_image, &block)
      end

      # @param [Integer|String] item_id
      # @param [Integer|String] image_no: from 1 to 20
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/delete_image
      def items_delete_image(item_id, image_no, &block)
        call_post_api('/1/items/delete_image', { item_id: item_id, image_no: image_no }, &block)
      end

      # @param [Hash] params
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/edit_stock
      def items_edit_stock(params, &block)
        call_post_api('/1/items/edit_stock', params, &block)
      end

      # @param [Integer|String] item_id
      # @param [Integer|String] variation_id
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/delete_variation
      def items_delete_variation(item_id, variation_id, &block)
        call_post_api('/1/items/delete_variation', { item_id: item_id, variation_id: variation_id }, &block)
      end
    end
  end
end
