class OpenweatherServices

  def initialize
    @conn = Faraday.new(url: "https://api.openweathermap.org/")
  end

  def get_forecast_by_lat_lng(coordinates)
    response = @conn.get("data/2.5/onecall?lat=#{coordinates[:lat]}&lon=#{coordinates[:lng]}&units=imperial&exclude=minutely&appid=#{ENV["OPENWEATHER_KEY"]}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
