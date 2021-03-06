class Api::V1::RoadTripsController < ApplicationController
  def create
    user = find_user_by_api_key(params["api_key"])
    if user
      point_a_point_b = params.extract!("origin","destination")
      response = CompileTripData.new(point_a_point_b)
      render json: response
    else
      render json: ["unauthorized"], status: :unauthorized
    end
  end
end
