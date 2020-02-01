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
end
