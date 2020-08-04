class Api::V1::ForecastController < ApplicationController
  def index
    CompileForecast.new(params["location"])
    render json: ForecastSerializer.new(Forecast.last)
    Forecast.delete_all
  end
end
