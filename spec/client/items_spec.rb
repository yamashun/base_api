RSpec.describe BaseApi::Client::Items do
  describe '.items', :vcr do
    before do
      BaseApi.reset!
    end

    let(:client) { BaseApi::Client.new(access_token: test_base_access_token) }

    it 'returns items' do
      reponse = client.items
      expect(reponse['items'].first['item_id']).not_to be_nil
      assert_requested :get, base_api_url("/1/items?offset=0&limit=10")
    end

    it 'returns items and returns next page' do
      reponse = client.items(limit: 1)
      expect(reponse['items'].first['item_id']).not_to be_nil
      assert_requested :get, base_api_url("/1/items?offset=0&limit=1")

      reponse2 = client.fetch_next_page
      expect(reponse2['items'].first['item_id']).not_to be_nil
      assert_requested :get, base_api_url("/1/items?offset=1&limit=1")
    end
  end

  describe '.items_search', :vcr do
    before do
      BaseApi.reset!
    end

    let(:client) { BaseApi::Client.new(access_token: test_base_access_token) }

    context 'without option' do
      let(:serach_word) { 'キングダム' }
      it 'returns items' do
        reponse = client.items_search(serach_word)
        expect(reponse['items'].first['item_id']).not_to be_nil
        assert_requested :get, base_api_url("/1/items/search?q=#{CGI.escape(serach_word)}&offset=0&limit=10")
      end
    end

    context 'with option' do
      let(:serach_word) { 'キングダム' }
      let(:option){ { fields: 'title,detail' } }
      it 'returns items' do
        reponse = client.items_search(serach_word, option)
        expect(reponse['items'].first['item_id']).not_to be_nil
        assert_requested :get, base_api_url("/1/items/search?q=#{CGI.escape(serach_word)}&offset=0&limit=10&fields=title,detail")
      end
    end
  end
end
