class HikingServices
  def  get_nearby_trails(location)
    @location = location
    conn = Faraday.new(url: "https://www.hikingproject.com/")
    response = conn.get("data/get-trails?lat=#{@location.lat}&lon=#{@location.long}&maxDistance=30&key=#{ENV['HIKING_KEY']}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
