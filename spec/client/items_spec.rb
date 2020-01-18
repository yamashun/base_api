RSpec.describe BaseApi::Client::Items do
  describe '.items', :vcr do
    before do
      BaseApi.reset!
    end

    let(:client) { BaseApi::Client.new(access_token: test_access_token) }

    it 'returns items' do
      items = client.items
      expect(items['items'].first['item_id']).not_to be_nil
      assert_requested :get, base_api_url("/1/items?offset=0&limit=10")
    end

    it 'returns items and returns next page' do
      items = client.items(limit: 1)
      expect(items['items'].first['item_id']).not_to be_nil
      assert_requested :get, base_api_url("/1/items?offset=0&limit=1")

      client.fetch_next_page
      expect(items['items'].first['item_id']).not_to be_nil
      assert_requested :get, base_api_url("/1/items?offset=1&limit=1")
    end
  end
end
