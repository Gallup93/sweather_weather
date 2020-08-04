class CompileForecast
  def initialize(location)
    location = LocationData.new(location)
    forecast_json = location.get_forecast
    parsed_json = parse_forecast(forecast_json)
    Forecast.create(parsed_json)
  end

  private

  def parse_forecast(forecast_json)
    relevant_data = {:general => {}, :current => {}, :hourly => [], :daily => []}

    tracker = nil

    forecast_json.each do |key, value|
      if relevant_data.keys.any?(key)
        tracker = key
      end
      if tracker == nil
        relevant_data[:general][key] = value
      elsif tracker == :current
        relevant_data[:current] = forecast_json[:current].extract!(:dt,:temp,:weather,:sunrise,:sunset,:feels_like,:humidity,:uvi,:visibility)
      elsif tracker == :hourly
        relevant_data[:hourly] = forecast_json[:hourly].map {|hour| hour.extract!(:temp,:weather,:dt)}
      else
        relevant_data[:daily] = forecast_json[:daily].map {|day| day.extract!(:temp,:weather,:rain)}
      end
    end
    relevant_data
  end
end
