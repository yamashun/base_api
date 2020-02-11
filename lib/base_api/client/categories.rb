module BaseApi
  class Client
    module Categories
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/categories/
      def categories(&block)
        call_get_api('/1/categories', &block)
      end

      # @param [String] name
      # @option param [Hash] option
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/categories/add
      def categories_add(name, option = {}, &block)
        call_post_api('/1/categories/add',  { name: name }.merge(option), &block)
      end

      # @param [Integer|String] category_id
      # @option param [Hash] option
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/categories/edit
      def categories_edit(category_id, option = {}, &block)
        call_post_api('/1/categories/edit',  { category_id: category_id }.merge(option), &block)
      end

      # @param [Integer|String] category_id
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/categories/delete
      def categories_delete(category_id, &block)
        call_post_api('/1/categories/delete', { category_id: category_id }, &block)
      end
    end
  end
end
