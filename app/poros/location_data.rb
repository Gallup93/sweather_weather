class LocationData
  attr_reader :city_state, :lat, :long
  def initialize(location)
    @city_state = location.split(",")
    @lat = nil
    @long = nil
    get_coordinates
  end

  def get_coordinates
    coords = MapquestServices.new.get_city_lat_lon(@city_state[0], @city_state[1])
    @lat= coords[:lat]
    @long = coords[:lng]
  end

  def get_forecast
    OpenweatherServices.new.get_forecast_by_lat_lng(@lat, @lon)
  end
end
