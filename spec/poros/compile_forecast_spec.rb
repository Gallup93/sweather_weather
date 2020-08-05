require 'rails_helper'

describe "expose ReST end points" do
  it "returns landing page forecast", :vcr do
    forecast = CompileForecast.new("rockford,il").landing_page_forecast

    general_keys = (["city", "state", "country", "lat", "lon", "timezone", "timezone_offset"])
    current_keys = ["dt", "temp", "weather", "sunrise", "sunset", "feels_like", "humidity", "uvi", "visibility"]
    weather_keys = (["id","main","description","icon"])


    expect(forecast[:general].keys).to eq(general_keys)
    expect(forecast[:current].keys.count).to eq(9)
    expect(forecast[:current].keys).to eq(current_keys)
    expect(forecast[:hourly].count).to eq(48)
    expect(forecast[:hourly][0]["weather"][0].keys).to eq(weather_keys)
    expect(forecast[:daily].count).to eq(8)
    expect(forecast[:daily][0]["weather"][0].keys).to eq(weather_keys)
  end
end
