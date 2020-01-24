RSpec.describe BaseApi::Client do
  describe '#initialize' do
    before do
      BaseApi::reset!
    end

    context 'with option args' do
      before do
        BaseApi::Configurable.keys.each do |key|
          BaseApi.configure do |config|
            config.send("#{key}=", key)
          end
        end
      end

      let(:options) do
        BaseApi::Configurable.keys.inject({}) do |hash, key|
          hash.merge(key => "option#{key}")
        end
      end

      it 'sets option args values' do
        client = BaseApi::Client.new(options)
        BaseApi::Configurable.keys.each do |key|
          expect(client.instance_variable_get(:"@#{key}")).to eq "option#{key}"
        end
      end
    end

    context 'without option args' do
      it 'sets class option values' do
        client = BaseApi::Client.new
        BaseApi::Configurable.keys.each do |key|
          expect_value = nil
          case key
          when :limit
            expect_value = 10
          when :offset
            expect_value = 0
          end
          expect(client.instance_variable_get(:"@#{key}")).to eq expect_value
        end
      end
    end
  end

  describe '#inspect' do
    before do
      BaseApi::reset!
    end

    it 'masks code' do
      code = '859f961367a1b91980d9e878fa64b0fb'
      client = BaseApi::Client.new(code: code)
      expect(client.inspect).not_to include(code)
    end

    it 'masks access_token' do
      access_token = '001037b74d13900f297732847e6dfaa9'
      client = BaseApi::Client.new(access_token: access_token)
      expect(client.inspect).not_to include(access_token)
    end

    it 'masks refresh_token' do
      refresh_token = 'bb1d422521c95b0f4a2e7d4c21ec9f6c'
      client = BaseApi::Client.new(refresh_token: refresh_token)
      expect(client.inspect).not_to include(refresh_token)
    end

    it 'masks client_secret' do
      client_secret = '793f6e7c65363ff23fa30b9750cbb61c'
      client = BaseApi::Client.new(client_secret: client_secret)
      expect(client.inspect).not_to include(client_secret)
    end

    it 'includes client_id' do
      client_id = 'ed3469be9e2aeddf0802ad7b011ef57c'
      client = BaseApi::Client.new(client_id: client_id)
      expect(client.inspect).to include(client_id)
    end
  end
end
