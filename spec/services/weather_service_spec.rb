require 'rails_helper'

RSpec.describe WeatherService do
  let(:forecast) { WeatherService.new(zip_code, country_code).get_forecast }

  describe '.get_forecast' do
    let(:zip_code) { '20500' }
    let(:country_code) { 'us' }

    before do
      allow(Rails.application.credentials).to receive(:openweather_api_key).and_return('appid')
    end

    context 'valid zip code and country code' do
      it 'returns a hash with the forecast data', vcr: { record: :once } do
        expect(forecast).to be_a(OpenStruct)
        expect(forecast.current_temp).to be_a(Float)
        expect(forecast.low_temp).to be_a(Float)
        expect(forecast.high_temp).to be_a(Float)
      end
    end

    context 'invalid zip code and country code' do
      let(:zip_code) { '' }
      let(:country_code) { '' }

      it 'raises an error', vcr: { record: :once } do
        expect do
          forecast
        end.to raise_error 'Missing zip_code/country_code'
      end
    end

    context 'no API response' do
      before do
        allow_any_instance_of(WeatherService).to receive(:open_weather_response).and_return({})
      end

      it 'raises an error'do
        expect do
          forecast
        end.to raise_error 'Response is empty. Try again later.'
      end
    end
  end
end
