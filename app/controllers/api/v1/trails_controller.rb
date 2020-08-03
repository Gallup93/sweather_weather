class Api::V1::TrailsController < ApplicationController
  def index
    forecast_json = get_forecast(get_coordinates)
    parsed_forecast = parse_trail_forecast(forecast_json)
    # forecast_object = Forecast.create(parsed_json)
    trails_json = get_trails(get_coordinates)
  end

  private

  def parse_trail_forecast(forecast_json)
    temp_weather = forecast_json[:current].extract!(:temp,:weather)
    temp_weather[:weather] = temp_weather[:weather][0][:description]
    temp_weather
  end
end
