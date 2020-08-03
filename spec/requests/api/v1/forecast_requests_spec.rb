require 'rails_helper'
describe "expose ReST end points" do
  context "from landing page" do

    it "returns all data needed for forecast" do
      forecast_info = File.read("spec/fixtures/denver_forecast.json")

      stub_request(:get, "http://localhost:3000/api/v1/forecast?location=denver,co").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v1.0.1'
          }).
        to_return(status: 200, body: forecast_info, headers: {})

      conn = Faraday.new(url: "http://localhost:3000/api/v1/")
      response = conn.get("forecast?location=denver,co")
      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast[:data][:attributes][:general][:timezone_offset]).to eq(-21600)
      expect(forecast[:data][:attributes][:current][:temp]).to eq(79.25)
      expect(forecast[:data][:attributes][:current].keys.count).to eq(9)
      expect(forecast[:data][:attributes][:hourly].count).to eq(48)
      expect(forecast[:data][:attributes][:hourly][0][:weather][0][:description]).to eq("broken clouds")
      expect(forecast[:data][:attributes][:daily].count).to eq(8)
      expect(forecast[:data][:attributes][:daily][0][:temp][:min]).to eq(73.99)
      expect(forecast[:data][:attributes][:daily][0][:temp][:max]).to eq(79.25)
    end
  end
end
