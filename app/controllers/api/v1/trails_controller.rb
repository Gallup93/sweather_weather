class Api::V1::TrailsController < ApplicationController
  def index
    location = LocationData.new(params["location"])
    trails = TripPlanner.new(location).hash
    render json: trails
  end
end
