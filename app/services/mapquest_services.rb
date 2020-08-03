class MapquestServices
  def get_city_lat_lon(city,state)
    conn = Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/")
    response = conn.get("address?key=#{ENV["MAPQUEST_KEY"]}&inFormat=kvp&outFormat=json&location=#{city}%2C+#{state}&thumbMaps=false")
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed[:results][0][:locations][0][:latLng]
  end
end
