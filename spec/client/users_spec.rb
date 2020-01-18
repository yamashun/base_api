RSpec.describe BaseApi::Client::Users do
  describe '.users_me', :vcr do
    before do
      BaseApi.reset!
    end

    let(:client) { BaseApi::Client.new(access_token: test_base_access_token) }

    it 'returns items' do
      reponse = client.users_me
      expect(reponse['user']).not_to be_nil
      assert_requested :get, base_api_url('/1/users/me')
    end
  end
end
