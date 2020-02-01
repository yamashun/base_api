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
end
