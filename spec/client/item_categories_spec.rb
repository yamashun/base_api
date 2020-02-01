RSpec.describe BaseApi::Client::ItemCategories do
  before do
    BaseApi.reset!
  end

  describe '.item_categories_detail', :vcr do
    let(:client) { BaseApi::Client.new(access_token: test_base_access_token) }
    let(:item_id) { 26105787 }

    it 'returns item categories' do
      reponse = client.item_categories_detail(item_id)
      expect(reponse['item_categories']).not_to be_nil
      assert_requested :get, base_api_url("/1/item_categories/detail/#{item_id}")
    end
  end

  describe '.item_categories_add', :vcr do
    let(:client) { BaseApi::Client.new(access_token: test_base_access_token) }
    let(:item_id) { 26105872 }
    let(:category_id) { 2159127 }

    it 'adds a item category' do
      reponse = client.item_categories_add(item_id, category_id)
      expect(reponse['item_categories']).not_to be_nil
      assert_requested :post, base_api_url('/1/item_categories/add'),
        body: URI.encode_www_form({ item_id: item_id, category_id: category_id })
    end
  end

  describe '.item_categories_delete', :vcr do
    let(:client) { BaseApi::Client.new(access_token: test_base_access_token) }
    let(:item_category_id) { 28218662 }

    it 'deletes a item category' do
      reponse = client.item_categories_delete(item_category_id)
      expect(reponse['item_categories']).not_to be_nil
      assert_requested :post, base_api_url('/1/item_categories/delete'),
        body: URI.encode_www_form({ item_category_id: item_category_id })
    end
  end
end
