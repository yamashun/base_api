require 'uri'

RSpec.describe BaseApi::Client::Items do
  describe '.items', :vcr do
    before do
      BaseApi.reset!
    end

    let(:client) { BaseApi::Client.new(access_token: test_base_access_token) }

    it 'returns items' do
      response = client.items
      expect(response['items'].first['item_id']).not_to be_nil
      assert_requested :get, base_api_url("/1/items?offset=0&limit=10")
    end

    it 'returns items and returns next page' do
      response = client.items(limit: 1)
      expect(response['items'].first['item_id']).not_to be_nil
      assert_requested :get, base_api_url("/1/items?offset=0&limit=1")

      response2 = client.fetch_next_page
      expect(response2['items'].first['item_id']).not_to be_nil
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
        response = client.items_search(serach_word)
        expect(response['items'].first['item_id']).not_to be_nil
        assert_requested :get, base_api_url("/1/items/search?q=#{CGI.escape(serach_word)}&offset=0&limit=10")
      end
    end

    context 'with option' do
      let(:serach_word) { 'キングダム' }
      let(:option){ { fields: 'title,detail' } }
      it 'returns items' do
        response = client.items_search(serach_word, option)
        expect(response['items'].first['item_id']).not_to be_nil
        assert_requested :get, base_api_url("/1/items/search?q=#{CGI.escape(serach_word)}&offset=0&limit=10&fields=title,detail")
      end
    end
  end

  describe '.items_detail', :vcr do
    before do
      BaseApi.reset!
    end
    let(:client) { BaseApi::Client.new(access_token: test_base_access_token) }
    let(:item_id) { 25931281 }

    it 'returns item detail' do
      response = client.items_detail(item_id)
      expect(response['item']).not_to be_nil
      assert_requested :get, base_api_url("/1/items/detail/#{item_id}")
    end
  end

  describe '.items_add', :vcr do
    before do
      BaseApi.reset!
    end
    let(:client) { BaseApi::Client.new(access_token: test_base_access_token) }
    let(:add_item) do
      {
        title: 'testitem',
        detail: 'testitemdetail',
        price: 1000,
        stock: 1
      }
    end

    it 'returns item detail' do
      response = client.items_add(add_item)
      expect(response['item']).not_to be_nil
      assert_requested :post, base_api_url('/1/items/add'), body: URI.encode_www_form(add_item)
    end
  end
end
