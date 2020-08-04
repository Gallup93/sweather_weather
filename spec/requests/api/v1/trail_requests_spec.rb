require 'rails_helper'

describe "expose trail end points" do
  it "returns all data needed for trails", :vcr do
    conn = Faraday.new(url: "http://localhost:3000/api/v1/")

    trails_response = conn.get("trails?location=denver,co")

    expect(trails_response.status).to eq(200)

    trails_info = JSON.parse(trails_response.body, symbolize_names: true)

    data_keys = [:id, :type, :attributes, :trails]
    attribute_keys = [:location, :forecast]
    forecast_keys = [:summary, :temperature]
    trail_keys = [:name, :summary, :difficulty, :location, :distance]

    expect(trails_info[:data].keys).to eq(data_keys)
    expect(trails_info[:data][:attributes].keys).to eq(attribute_keys)
    expect(trails_info[:data][:attributes][:forecast].keys).to eq(forecast_keys)
    expect(trails_info[:data][:trails][0].keys).to eq(trail_keys)
  end
end
