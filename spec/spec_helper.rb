require "bundler/setup"
require "base_api"
require "pry"
require 'webmock/rspec'
require 'vcr'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.hook_into :webmock
  c.filter_sensitive_data('<BearerToken>') { test_base_access_token }
  c.filter_sensitive_data('<BaseCode>') { test_base_code }
  c.filter_sensitive_data('<BaseClientId>') { test_base_client_id }
  c.filter_sensitive_data('<BaseClientSecret>') { test_base_client_secret }
  c.filter_sensitive_data('<BaseRedirectURI>') { test_base_redirect_uri }
end


def base_api_url(url)
  return url if url =~ /^http/

  url = File.join('https://api.thebase.in', url)
  uri = Addressable::URI.parse(url)

  uri.to_s
end

def test_base_access_token
  ENV.fetch('BASE_API_ACCESS_TOKEN'){ 'hogehogeaccesstoken' }
end

def test_base_code
  ENV.fetch('BASE_API_CODE'){ 'hogehogecode' }
end

def test_base_client_id
  ENV.fetch('BASE_API_CLIENT_ID'){ 'hogehogeclientid' }
end

def test_base_client_secret
  ENV.fetch('BASE_API_CLIENT_SECRET'){ 'hogehogeclientsecret' }
end

def test_base_redirect_uri
  ENV.fetch('BASE_API_REDIRECT_URI'){ 'hogehogeredirecturi' }
end
