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

      # @param [Hash] item
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/edit
      def items_edit(item)
        post_call_api('/1/items/edit', item)
      end

      # @param [Integer|String] item_id
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/delete
      def items_delete(item_id)
        post_call_api('/1/items/delete', { item_id: item_id })
      end

      # @param [Hash] item_image
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/add_image
      def items_add_image(item_image)
        post_call_api('/1/items/add_image', item_image)
      end

      # @param [Integer|String] item_id
      # @param [Integer|String] image_no: from 1 to 20
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/delete_image
      def items_delete_image(item_id, image_no)
        post_call_api('/1/items/delete_image', { item_id: item_id, image_no: image_no })
      end

      # @param [Hash] params
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/items/edit_stock
      def items_edit_stock(params)
        post_call_api('/1/items/edit_stock', params)
      end
    end
  end
end
