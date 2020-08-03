require 'rails_helper'
describe "expose trail end points" do
  it "returns all data needed for trails", :vcr do
    conn = Faraday.new(url: "http://localhost:3000/api/v1/")

    trail_response = conn.get("trails?location=denver,co")

    expect(trail_response.status).to eq(200)

    trail_info = JSON.parse(trail_response.body, symbolize_names: true)
    require "pry";binding.pry
  end
end
