class TripPlanner
  attr_reader :hash
  def initialize(location)
    @location = location
    trails_data = relevant_trail_data(TrailsNearby.new(location.city_state).find)
    forecast_data = relevant_forecast_data(OpenweatherServices.new.get_forecast_by_lat_lng(location.lat, location.long))
    @hash = ({"data" => {"id" => nil, "type" => "trail", "attributes" => {"location" => @location.city_state.join(" "), "forecast" => forecast_data["forecast"]}, "trails" => trails_data}})
  end

  def get_distance_to_trail(trail_location)
    MapquestServices.new.get_trail_distance(trail_location, @location.city_state)
  end

  def relevant_trail_data(trails_data)
    parsed_trails = Array.new
    temp = Hash.new
    trails_data[:trails].each do |trail|
      temp = trail.extract!(:name, :summary, :difficulty, :location)
      distance = get_distance_to_trail(temp[:location])
      temp[:distance] = distance
      parsed_trails << temp
      temp = Hash.new
    end
    parsed_trails
  end

  def relevant_forecast_data(forecast_data)
    forecast_data[:current]
    relevant_data = {"forecast" => Hash.new}
    relevant_data["forecast"]["summary"] = forecast_data[:current][:weather][0][:description]
    relevant_data["forecast"]["temperature"] = forecast_data[:current][:temp]
    relevant_data
  end
end
