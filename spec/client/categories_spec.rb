RSpec.describe BaseApi::Client::Categories do
  before do
    BaseApi.reset!
  end

  describe '.categories', :vcr do
    let(:client) { BaseApi::Client.new(access_token: test_base_access_token) }

    it 'returns categories' do
      reponse = client.categories
      expect(reponse['categories']).not_to be_nil
      assert_requested :get, base_api_url('/1/categories')
    end
  end

  describe '.categories_add', :vcr do
    let(:client) { BaseApi::Client.new(access_token: test_base_access_token) }
    let(:name) { 'category2' }
    let(:option) { { list_order: 2, parent_number: 1 } }

    it 'adds a category' do
      reponse = client.categories_add(name, option)
      expect(reponse['categories']).not_to be_nil
      assert_requested :post, base_api_url('/1/categories/add'),
        body: URI.encode_www_form({ name: name}.merge(option))
    end
  end

  describe '.categories_edit', :vcr do
    let(:client) { BaseApi::Client.new(access_token: test_base_access_token) }
    let(:category_id) { 2159157 }
    let(:option) { { name: 'updatecategory' } }

    it 'updates a category' do
      reponse = client.categories_edit(category_id, option)
      expect(reponse['categories']).not_to be_nil
      assert_requested :post, base_api_url('/1/categories/edit'),
        body: URI.encode_www_form({ category_id: category_id }.merge(option))
    end
  end

  describe '.categories_delete', :vcr do
    let(:client) { BaseApi::Client.new(access_token: test_base_access_token) }
    let(:category_id) { 2159157 }

    it 'deletes a category' do
      reponse = client.categories_delete(category_id)
      expect(reponse['categories']).not_to be_nil
      assert_requested :post, base_api_url('/1/categories/delete'),
        body: URI.encode_www_form({ category_id: category_id })
    end
  end
end
