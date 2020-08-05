class CompileForecast
  def initialize(location)
    @location = CompileLocationData.new(location)
    @forecast_json = @location.forecast
  end

  def landing_page_forecast
    relevant_data = {:general => {}, :current => {}, :hourly => [], :daily => []}

    tracker = nil

    @forecast_json.each do |key, value|
      relevant_data[:general][:city] = @location.details[:city]
      relevant_data[:general][:state] = @location.details[:state]
      relevant_data[:general][:country] = @location.details[:country]

      if relevant_data.keys.any?(key)
        tracker = key
      end
      if tracker == nil
        relevant_data[:general][key] = value
      elsif tracker == :current
        relevant_data[:current] = @forecast_json[:current].extract!(:dt,:temp,:weather,:sunrise,:sunset,:feels_like,:humidity,:uvi,:visibility)
      elsif tracker == :hourly
        relevant_data[:hourly] = @forecast_json[:hourly].map {|hour| hour.extract!(:temp,:weather,:dt)}
      else
        relevant_data[:daily] = @forecast_json[:daily].map {|day| day.extract!(:temp,:weather,:rain)}
      end
    end
    Forecast.create(relevant_data)
  end

  def trip_forecast(travel_time)
    minutes = travel_time.to_f / 60
    hours = (minutes / 60).round
    arrival_hour = (Time.now.hour + hours)
    relevant_data = Hash.new
    relevant_data[:temp] = @forecast_json[:hourly][arrival_hour][:temp]
    relevant_data[:summary] = @forecast_json[:hourly][arrival_hour][:weather][0][:description]
    relevant_data
  end
end
