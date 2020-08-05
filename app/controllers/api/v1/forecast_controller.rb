class Api::V1::ForecastController < ApplicationController
  def index
    CompileForecast.new(params["location"]).landing_page_forecast
    render json: ForecastSerializer.new(Forecast.last)
  end
end
