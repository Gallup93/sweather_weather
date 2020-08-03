class Api::V1::ForecastController < ApplicationController
  def index
    forecast_json = get_forecast(get_coordinates)
    parsed_json = parse_forecast(forecast_json)
    forecast_object = Forecast.create(parsed_json)
    render json: ForecastSerializer.new(forecast_object)
    Forecast.delete_all
  end

  private

  def get_coordinates
    location = params["location"].split(",")
    MapquestServices.new.get_city_lat_lon(location[0], location[1])
  end

  def get_forecast(coordinates)
    OpenweatherServices.new.get_forecast_by_lat_lng(coordinates)
  end

  def parse_forecast(forecast_json)
    relevant_data = {:general => {}, :current => {}, :hourly => [], :daily => []}

    tracker = nil

    forecast_json.each do |key, value|
      if relevant_data.keys.any?(key)
        tracker = key
      end
      if tracker == nil
        relevant_data[:general][key] = value
      elsif tracker == :current
        relevant_data[:current] = forecast_json[:current].extract!(:dt,:temp,:weather,:sunrise,:sunset,:feels_like,:humidity,:uvi,:visibility)
      elsif tracker == :hourly
        relevant_data[:hourly] = forecast_json[:hourly].map {|hour| hour.extract!(:dt,:temp,:weather)}
      else
        relevant_data[:daily] = forecast_json[:daily].map {|day| day.extract!(:temp,:weather,:rain)}
      end
    end
    relevant_data
  end
end
