class ForecastsController < ApplicationController
  def show
    @address = forecast_params[:address]
    return unless @address.present?

    begin
      @forecast_cache_exist = Rails.cache.exist?(cache_key)
      @forecast = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
        WeatherService.new(geocode.zip_code, geocode.country_code).get_forecast
      end
    rescue Exception => e
      flash.alert = e.message
      redirect_to root_path
    end
  end

  private

  def forecast_params
    params.permit(:address)
  end

  def geocode
    @geocode ||= GeocoderService.new(@address).geocode
  end

  def cache_key
    "#{geocode.zip_code}-#{geocode.country_code}"
  end
end
