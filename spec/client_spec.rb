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
          expect(client.instance_variable_get(:"@#{key}")).to eq ""
        end
      end
    end
  end
end
