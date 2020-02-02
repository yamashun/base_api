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
        call_get_api("/1/items/detail/#{item_id}")
      end

      # @param [Hash] item
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/add
      def items_add(item)
        call_post_api('/1/items/add', item)
      end

      # @param [Hash] item
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/edit
      def items_edit(item)
        call_post_api('/1/items/edit', item)
      end

      # @param [Integer|String] item_id
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/delete
      def items_delete(item_id)
        call_post_api('/1/items/delete', { item_id: item_id })
      end

      # @param [Hash] item_image
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/add_image
      def items_add_image(item_image)
        call_post_api('/1/items/add_image', item_image)
      end

      # @param [Integer|String] item_id
      # @param [Integer|String] image_no: from 1 to 20
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/delete_image
      def items_delete_image(item_id, image_no)
        call_post_api('/1/items/delete_image', { item_id: item_id, image_no: image_no })
      end

      # @param [Hash] params
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/edit_stock
      def items_edit_stock(params)
        call_post_api('/1/items/edit_stock', params)
      end

      # @param [Integer|String] item_id
      # @param [Integer|String] variation_id
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/delete_variation
      def items_delete_variation(item_id, variation_id)
        call_post_api('/1/items/delete_variation', { item_id: item_id, variation_id: variation_id })
      end
    end
  end
end
