require 'rails_helper'

RSpec.describe GeocoderService do
  describe '.geocode' do
    let(:geocoded_data) { GeocoderService.new(address).geocode }

    context 'valid address' do
      let(:address) { '1600 Pennsylvania Ave NW, Washington, DC' }

      it 'returns a hash with the geocoded data', vcr: { record: :once } do
        expect(geocoded_data).to be_a(OpenStruct)
        expect(geocoded_data.zip_code).to eq '20500'
        expect(geocoded_data.country_code).to eq 'US'
      end
    end

    context 'invalid address' do
      let(:address) { '' }

      it 'raies an error', vcr: { record: :once }  do
        expect do
          geocoded_data
        end.to raise_error "Invalid request. Missing the 'address', 'components', 'latlng' or 'place_id' parameter."
      end
    end
  end
end
