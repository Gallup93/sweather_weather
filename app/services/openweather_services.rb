class OpenweatherServices

  def initialize
    @conn = Faraday.new(url: "https://api.openweathermap.org/")
  end

  def get_forecast_by_lat_lng(coordinates)
    response = @conn.get("data/2.5/onecall?lat=#{coordinates[:lat]}&lon=#{coordinates[:lng]}&units=imperial&exclude=minutely&appid=#{ENV["OPENWEATHER_KEY"]}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def parse_forecast_data(forecast_data)
    relevant_data = {:general => {}, :current => {}, :hourly => [], :daily => []}

    tracker = nil

    forecast_data.each do |key, value|
      if relevant_data.keys.any?(key)
        tracker = key
      end
      if tracker == nil
        relevant_data[:general][key] = value
      elsif tracker == :current
        relevant_data[:current] = forecast_data[:current].extract!(:dt, :temp, :weather, :sunrise, :sunset, :feels_like, :humidity, :uvi, :visibility)
      elsif tracker == :hourly
        relevant_data[:hourly] = forecast_data[:hourly].map {|hour| hour.extract!(:dt, :temp, :weather)}
      else
        relevant_data[:daily] = forecast_data[:daily].map {|day| day.extract!(:temp, :weather, :rain)}
      end
    end
    relevant_data
  end
end
