class Api::V1::RoadTripsController < ApplicationController
  def create
    user = find_user_by_api_key(params["api_key"])
    if user
      response = CompileTripData.new(params.extract!("origin","destination"))
      render json: response
    else
      render json: ["unauthorized"], status: :unauthorized
    end
  end
end
