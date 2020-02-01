module BaseApi
  class Client
    module Categories
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/categories/
      def categories
        get_call_api('/1/categories')
      end

      # @param [String] name
      # @option param [Hash] option
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/categories/add
      def categories_add(name, option = {})
        post_call_api('/1/categories/add',  { name: name }.merge(option))
      end

      # @param [Integer|String] category_id
      # @option param [Hash] option
      # @return [HTTParty::Response]
      # @see https://docs.thebase.in/docs/api/categories/edit
      def categories_edit(category_id, option = {})
        post_call_api('/1/categories/edit',  { category_id: category_id }.merge(option))
      end
    end
  end
end
