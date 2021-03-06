class MapquestServices
  def initialize
    @conn = Faraday.new(url: "https://www.mapquestapi.com")
  end
  def get_city_lat_lon(city,state)
    response = @conn.get("/geocoding/v1/address?key=#{ENV["MAPQUEST_KEY"]}&inFormat=kvp&outFormat=json&location=#{city}%2C+#{state}&thumbMaps=false")
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:results][0][:locations][0][:latLng]
  end

  def get_trail_distance(origin, destination)
    response = @conn.get("/directions/v2/route?key=#{ENV['MAPQUEST_KEY']}&from=#{origin.split(",")[0]}%2C+#{origin.split(",")[1]}&to=#{destination.split(",")[0]}%2C+#{destination.split(",")[1].strip}&outFormat=json&ambiguities=ignore&routeType=fastest&doReverseGeocode=false&enhancedNarrative=false&avoidTimedConditions=false")
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:route][:distance]
  end

  def get_time_to_trail(origin, destination)
    response = @conn.get("/directions/v2/route?key=#{ENV['MAPQUEST_KEY']}&from=#{origin.split(",")[0]}%2C+#{origin.split(",")[1]}&to=#{destination.split(",")[0]}%2C+#{destination.split(",")[1].strip}&outFormat=json&ambiguities=ignore&routeType=fastest&doReverseGeocode=false&enhancedNarrative=false&avoidTimedConditions=false")
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:route][:realTime]
  end

  def get_info_by_coordinates(lat,long)
    response = @conn.get("/geocoding/v1/reverse?key=#{ENV['MAPQUEST_KEY']}&location=#{lat}%2C#{long}&outFormat=json&thumbMaps=false")
    parsed = JSON.parse(response.body, symbolize_names: true)
    relevant_data = {city: nil, state: nil, country: nil}
    relevant_data[:city] = parsed[:results][0][:locations][0][:adminArea5]
    relevant_data[:state] = parsed[:results][0][:locations][0][:adminArea3]
    relevant_data[:country] = parsed[:results][0][:locations][0][:adminArea1]
    relevant_data
  end
end
