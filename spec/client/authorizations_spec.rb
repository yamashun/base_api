RSpec.describe BaseApi::Client::Authorizations do

  describe '.oauth_access_token', :vcr do
    before do
      BaseApi.reset!
    end

    let(:client) do
      BaseApi::Client.new(
        code: authorization_code,
        access_token: nil,
        refresh_token: nil
      )
    end

    context 'with valid code' do
      let(:authorization_code) { test_base_code }
      let(:request_body) do
        {
          grant_type: 'authorization_code',
          client_id: test_base_client_id,
          client_secret: test_base_client_secret,
          code: authorization_code,
          redirect_uri: test_base_redirect_uri
        }
      end

      it 'returns tokens' do
        client.oauth_access_token
        expect(client.access_token).not_to be_nil
        expect(client.refresh_token).not_to be_nil
        assert_requested :post, base_api_url("/1/oauth/token"), body: request_body
      end

      context 'with block' do
        let(:model_mock) { double('Base model') }

        it 'returns tokens and block yeild' do
          # @see spec/fixtures/vcr_cassettes/BaseApi_Client_Authorizations/_oauth_access_token/with_valid_code/with_block/returns_tokens_and_block_yeild.yml
          expect(model_mock).to receive(:save).with(
            access_token: "BearerToken", refresh_token: "RefreshToken"
          )

          client.oauth_access_token do |res, err|
            if err.nil?
              model_mock.save(
                access_token: res['access_token'], refresh_token: res['refresh_token']
              )
            end
          end

          expect(client.access_token).not_to be_nil
          expect(client.refresh_token).not_to be_nil
          assert_requested :post, base_api_url("/1/oauth/token"), body: request_body
        end
      end
    end

    context 'with invalid code' do
      let(:authorization_code) { 'invalid code' }
      let(:request_body) do
        {
          grant_type: 'authorization_code',
          client_id: test_base_client_id,
          client_secret: test_base_client_secret,
          code: authorization_code,
          redirect_uri: test_base_redirect_uri
        }
      end

      it 'returns client errors' do
        begin
          client.oauth_access_token
        rescue => e
          expect(e.is_a?(BaseApi::ClientError)).to be true
        end
        response = client.response

        expect(response.client_error?).to be true
        expect(client.access_token).to be_nil
        expect(client.refresh_token).to be_nil
        assert_requested :post, base_api_url("/1/oauth/token"), body: request_body
      end

      context 'with block' do
        let(:model_mock) { double('Base model') }

        it 'returns client errors and block yeild' do
          # TODO: add public interface to handle error response
          expect(model_mock).to receive(:invalidate)
          response = client.oauth_access_token do |res, err|
            if err
              model_mock.invalidate
            end
          end

          expect(response.client_error?).to be true
          expect(client.access_token).to be_nil
          expect(client.refresh_token).to be_nil
          assert_requested :post, base_api_url("/1/oauth/token"), body: request_body
        end
      end
    end
  end

  describe '.oauth_refresh_token', :vcr do
    before do
      BaseApi.reset!
    end

    let(:client) do
      BaseApi::Client.new(
        access_token: nil,
        refresh_token: refresh_token
      )
    end

    context 'with valid refresh token' do
      let(:refresh_token) { test_base_refresh_token }
      let(:request_body) do
        {
          grant_type: 'refresh_token',
          client_id: test_base_client_id,
          client_secret: test_base_client_secret,
          refresh_token: refresh_token,
          redirect_uri: test_base_redirect_uri
        }
      end

      it 'returns tokens' do
        client.oauth_refresh_token
        expect(client.access_token).not_to be_nil
        expect(client.refresh_token).not_to be_nil
        assert_requested :post, base_api_url("/1/oauth/token"), body: request_body
      end

      context 'with block' do
        let(:model_mock) { double('Base model') }

        it 'returns tokens and block yeild' do
          # @see spec/fixtures/vcr_cassettes/BaseApi_Client_Authorizations/_oauth_refresh_token/with_valid_refresh_token/with_block/returns_tokens_and_block_yeild.yml
          expect(model_mock).to receive(:save).with(
            access_token: "BearerToken", refresh_token: "RefreshToken"
          )

          client.oauth_refresh_token do |res, err|
            if err.nil?
              model_mock.save(
                access_token: res['access_token'], refresh_token: res['refresh_token']
              )
            end
          end

          expect(client.access_token).not_to be_nil
          expect(client.refresh_token).not_to be_nil
          assert_requested :post, base_api_url("/1/oauth/token"), body: request_body
        end
      end
    end

    context 'with invalid refresh token' do
      let(:refresh_token) { 'invalid token' }
      let(:request_body) do
        {
          grant_type: 'refresh_token',
          client_id: test_base_client_id,
          client_secret: test_base_client_secret,
          refresh_token: refresh_token,
          redirect_uri: test_base_redirect_uri
        }
      end

      it 'returns client errors' do
        begin
          client.oauth_refresh_token
        rescue => e
          expect(e.is_a?(BaseApi::ClientError)).to be true
        end
        response = client.response

        expect(response.client_error?).to be true
        expect(client.access_token).to be_nil
        expect(client.refresh_token).to eq refresh_token
        assert_requested :post, base_api_url("/1/oauth/token"), body: request_body
      end

      context 'with block' do
        let(:model_mock) { double('Base model') }

        it 'returns client errors and yeild' do
          # TODO: add public interface to handle error response
          expect(model_mock).to receive(:invalidate)
          response = client.oauth_refresh_token do |res, err|
            if err
              model_mock.invalidate
            end
          end

          expect(response.client_error?).to be true
          expect(client.access_token).to be_nil
          expect(client.refresh_token).to eq refresh_token
          assert_requested :post, base_api_url("/1/oauth/token"), body: request_body
        end
      end
    end
  end
end
