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

  describe '.items_edit', :vcr do
    before do
      BaseApi.reset!
    end
    let(:client) { BaseApi::Client.new(access_token: test_base_access_token) }
    let(:edit_item) do
      {
        item_id: '26105902',
        title: 'testitemchange',
        detail: 'testitemdetail',
        price: 1200,
        stock: 1
      }
    end

    it 'returns item detail' do
      response = client.items_edit(edit_item)
      expect(response['item']).not_to be_nil
      assert_requested :post, base_api_url('/1/items/edit'), body: URI.encode_www_form(edit_item)
    end
  end

  describe '.items_delete', :vcr do
    before do
      BaseApi.reset!
    end
    let(:client) { BaseApi::Client.new(access_token: test_base_access_token) }
    let(:item_id) { '26105902' }

    it 'returns item detail' do
      response = client.items_delete(item_id)
      expect(response['result']).to be true
      assert_requested :post, base_api_url('/1/items/delete')
    end
  end

  describe '.items_add_image', :vcr do
    before do
      BaseApi.reset!
    end
    let(:client) { BaseApi::Client.new(access_token: test_base_access_token) }
    let(:item_image) do
      {
        item_id: 26105775,
        image_no: 1,
        image_url: 'https://basefile.akamaized.net/yamashun/5e2d0a541fabc/ruby-icon-6555.jpg'
      }
    end

    it 'returns item detail' do
      response = client.items_add_image(item_image)
      expect(response['item']).not_to be_nil
      assert_requested :post, base_api_url('/1/items/add_image')
    end
  end
end
