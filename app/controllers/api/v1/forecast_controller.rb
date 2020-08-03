class Api::V1::ForecastController < ApplicationController
  def index
    location = params["location"].split(",")
    coordinates = MapquestServices.new.get_city_lat_lon(location[0], location[1])
    service = OpenweatherServices.new
    forecast_json = service.get_forecast_by_lat_lng(coordinates)
    parsed_forecast_json = service.parse_forecast_data(forecast_json)
    forecast_object = Forecast.create(parsed_forecast_json)
    render json: ForecastSerializer.new(forecast_object)
    Forecast.delete_all
  end
end
