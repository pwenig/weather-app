class GeocoderService

  BASE_URL = 'https://maps.googleapis.com/maps/api/geocode/json'.freeze

  attr_accessor :geocode_data

  def initialize(address)
    @address = address
  end

  def geocode
    get_geocoder_response
    OpenStruct.new(
      zip_code: postal_code,
      country_code: country_code
    )
  end

  private

  def get_geocoder_response
    response = HTTParty.get(geocoder_url)
    if response['results'].empty?
      message = response['error_message'].present? ? response['error_message']: 'Invalid request. Try again.'
      raise Exception.new(message)
    else
      self.geocode_data = response['results'].first
    end
  end

  def postal_code
    @postal_code ||= geocode_data['address_components'].find {|x| x['types'] == ['postal_code']}['short_name']
  end

  def country_code
    @country_code ||= geocode_data['address_components'].find {|x| x['types'] == ["country", "political"]}['short_name']
  end

  def geocoder_url
    "#{BASE_URL}?address=#{@address}&#{geocoder_key}"
  end

  def geocoder_key
   "key=#{Rails.application.credentials.geocoder_api_key}"
  end
end
