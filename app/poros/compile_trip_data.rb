class CompileTripData

  def initialize(start_end_points)
    @origin = start_end_points["origin"]
    @destination  = start_end_points["destination"]
    @travel_time = get_travel_time
    @arrival_forecast = get_destination_forecast
  end

  def get_travel_time
    MapquestServices.new.get_time_to_trail(@origin, @destination)
  end

  def get_destination_forecast
    CompileForecast.new(@destination).trip_forecast(@travel_time)
  end
end
