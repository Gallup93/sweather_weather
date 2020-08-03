require 'rails_helper'
describe "expose ReST end points" do
  context "from landing page" do
    it "returns all data needed for forecast", :vcr do
      conn = Faraday.new(url: "http://localhost:3000/api/v1/")
      response = conn.get("forecast?location=denver,co")

      expect(response.status).to eq(200)

      forecast = JSON.parse(response.body, symbolize_names: true)
      general_keys = ([:lat, :lon, :timezone, :timezone_offset])
      weather_keys = ([:id,:main,:description,:icon])

      expect(forecast[:data][:attributes][:general].keys).to eq(general_keys)
      expect(forecast[:data][:attributes][:current].keys.count).to eq(9)
      expect(forecast[:data][:attributes][:current][:weather][0].keys).to eq(weather_keys)
      expect(forecast[:data][:attributes][:hourly].count).to eq(48)
      expect(forecast[:data][:attributes][:hourly][0][:weather][0].keys).to eq(weather_keys)
      expect(forecast[:data][:attributes][:daily].count).to eq(8)
      expect(forecast[:data][:attributes][:daily][0][:weather][0].keys).to eq(weather_keys)
    end
  end
end
