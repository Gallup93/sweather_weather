require 'rails_helper'

describe "expose ReST end points" do
  it "returns relevant 'road trip' data (with valid api_key)", :vcr do
    post '/api/v1/users?email=turing@aol.com&password=password&password_confirmation=password'
    user = User.last
    post "/api/v1/road_trip?origin=denver,co&destination=pueblo,co&api_key=#{user.api_key}"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:origin]).to eq("denver,co")
    expect(json[:destination]).to eq("pueblo,co")
    expect(json[:travel_time]).to_not eq(nil)
    expect(json[:arrival_forecast].keys).to eq([:temp,:summary])
  end
end
