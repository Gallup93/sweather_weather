class MapquestServices
  def get_city_lat_lon(city,state)
    conn = Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/")
    response = conn.get("address?key=#{ENV["MAPQUEST_KEY"]}&inFormat=kvp&outFormat=json&location=#{city}%2C+#{state}&thumbMaps=false")
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:results][0][:locations][0][:latLng]
  end

  def get_trail_distance(trail_location, starting_location)

    conn = Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/")
    response = conn.get("directions/v2/route?key=#{ENV['MAPQUEST_KEY']}&from=#{starting_location.split(",")[0]}%2C+#{starting_location.split(",")[1]}&to=#{trail_location.split(",")[0]}%2C+#{trail_location.split(",")[1].strip}&outFormat=json&ambiguities=ignore&routeType=fastest&doReverseGeocode=false&enhancedNarrative=false&avoidTimedConditions=false")
    require "pry";binding.pry
    parsed = JSON.parse(response.body, symbolize_names: true)

    require "pry";binding.pry
  end
end
