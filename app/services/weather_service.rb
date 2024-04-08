class WeatherService

  attr_accessor :forecast_data

  def initialize(zip_code, country_code)
    @zip_code = zip_code
    @country_code = country_code
  end

  def get_forecast
    get_current_weather
    OpenStruct.new(
      current_temp: current_temp,
      low_temp: low_temp,
      high_temp: high_temp
    )
  end

  private

  def get_current_weather
    if open_weather_response.empty?
      raise Exception.new('Response is empty. Try again later.')
    else
      self.forecast_data = open_weather_response
    end
  end

  def open_weather_response
    raise Exception.new('Missing zip_code/country_code') if @zip_code.empty? || @country_code.empty?

    @open_weather_response ||= client.current_weather(zip: @zip_code, country: @country_code.upcase)
  end

  def current_temp
    @current_temp ||=forecast_data.main.temp_f
  end

  def low_temp
    @low_temp ||= forecast_data.main.temp_min_f
  end

  def high_temp
    @high_temp ||= forecast_data.main.temp_max_f
  end

  def client
    OpenWeather::Client.new(
      api_key: Rails.application.credentials.openweather_api_key
    )
  end
end
