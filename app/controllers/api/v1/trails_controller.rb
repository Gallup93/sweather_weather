class Api::V1::TrailsController < ApplicationController
  def index
    forecast_json = get_forecast(get_coordinates(params["location"]))
    parsed_forecast = parse_trail_forecast(forecast_json)
    parsed_forecast[:location] = params["location"]

    trails_json = get_trails(get_coordinates(params["location"]))
    parsed_trails = parse_trail_data(trails_json)

    result = {:attributes => parsed_forecast, :trails => parsed_trails}
    render json: result
  end

  private

  def parse_trail_forecast(forecast_json)
    temp_weather = forecast_json[:current].extract!(:temp,:weather)
    temp_weather[:weather] = temp_weather[:weather][0][:description]
    temp_weather
  end

  def parse_trail_data(trails_json)
    parsed_trails = Array.new
    temp = Hash.new
    trails_json[:trails].each do |trail|
      temp = trail.extract!(:name, :summary, :difficulty, :location)
      distance = get_distance_to_trail(temp[:location])
      temp[:distance] = distance
      parsed_trails << temp
      temp = Hash.new
    end
    parsed_trails
  end
end
