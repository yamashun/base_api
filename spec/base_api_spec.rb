RSpec.describe BaseApi do
  it "has a version number" do
    expect(BaseApi::VERSION).not_to be '0.1.0'
  end

  describe '.configure' do
    BaseApi::Configurable.keys.each do |key|
      it "sets the #{key.to_s.gsub('_', ' ')}" do
        BaseApi.configure do |config|
          config.send("#{key}=", key)
        end
        expect(BaseApi.instance_variable_get(:"@#{key}")).to eq(key)
      end
    end
  end
end
