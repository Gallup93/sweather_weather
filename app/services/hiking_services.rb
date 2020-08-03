class HikingServices
  def get_trails_nearby(coordinates)
    conn = Faraday.new(url: "https://www.hikingproject.com/")
    response = conn.get("data/get-trails?lat=#{coordinates[:lat]}&lon=#{coordinates[:lng]}&maxDistance=30&key=#{ENV['HIKING_KEY']}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
