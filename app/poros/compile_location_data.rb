class CompileLocationData
  attr_reader :city_state, :lat, :long, :details
  def initialize(location)
    @city_state = location.split(",")
    @lat = nil
    @long = nil
    @details = nil
    get_coordinates
    get_info_by_coordinates
  end

  def get_coordinates
    coords = MapquestServices.new.get_city_lat_lon(@city_state[0], @city_state[1])
    @lat= coords[:lat]
    @long = coords[:lng]
  end

  def get_info_by_coordinates
    @details = MapquestServices.new.get_info_by_coordinates(@lat, @long)
  end

  def get_forecast
    OpenweatherServices.new.get_forecast_by_lat_lng(@lat, @long)
  end
end
