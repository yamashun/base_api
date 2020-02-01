RSpec.describe BaseApi::Client::Categories do
  describe '.categories', :vcr do
    before do
      BaseApi.reset!
    end
    let(:client) { BaseApi::Client.new(access_token: test_base_access_token) }

    it 'returns categories' do
      reponse = client.categories
      expect(reponse['categories']).not_to be_nil
      assert_requested :get, base_api_url('/1/categories')
    end
  end

  describe '.categories_add', :vcr do
    before do
      BaseApi.reset!
    end
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
end
