class TrailsNearby
  def initialize(location)
    @location = LocationData.new(location)
    @lat = LocationData.new(location).lat
    @long = LocationData.new(location).long
  end

  def find
    HikingServices.new.get_nearby_trails(@location)
  end
end
