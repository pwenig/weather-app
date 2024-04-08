VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true
  config.configure_rspec_metadata!
  config.default_cassette_options = { record: :none }
  config.filter_sensitive_data('<key>') do
    Rails.application.credentials.geocoder_api_key
  end
  config.filter_sensitive_data('appid') do
    Rails.application.credentials.openweather_api_key
  end
end
