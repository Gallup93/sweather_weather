class Api::V1::ForecastController < ApplicationController
  def index
    forecast_json = get_forecast(get_coordinates)
    parsed_json = parse_forecast(forecast_json)
    forecast_object = Forecast.create(parsed_json)
    render json: ForecastSerializer.new(forecast_object)
    Forecast.delete_all
  end
end
