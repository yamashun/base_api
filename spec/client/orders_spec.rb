RSpec.describe BaseApi::Client::Orders do
  describe '.orders', :vcr do
    before do
      BaseApi.reset!
    end

    let(:client) { BaseApi::Client.new(access_token: test_base_access_token) }

    it 'returns orders' do
      reponse = client.orders
      expect(reponse['orders']).not_to be_nil
      assert_requested :get, base_api_url("/1/orders?limit=#{BaseApi::Default.limit}&offset=0")
    end

    # TODO: add pagination test case
  end

  describe '.orders_detail', :vcr do
    before do
      BaseApi.reset!
    end

    let(:client) { BaseApi::Client.new(access_token: test_base_access_token) }
    let(:unique_key) { 'testuniquekey' }

    it 'returns order' do
      reponse = client.orders_detail(unique_key)
      expect(reponse['order']).not_to be_nil
      assert_requested :get, base_api_url("/1/orders/detail/#{unique_key}")
    end
  end
end
