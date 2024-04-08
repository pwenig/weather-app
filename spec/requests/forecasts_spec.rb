require 'rails_helper'

RSpec.describe 'Forecasts', type: :request do
  describe 'get /forecast/:address' do
    let(:address) { Faker::Address.full_address }

    subject { get forecasts_show_path, params: { address: } }

    it 'renders show' do
      subject
      expect(status).to eq(302)
    end
  end
end
