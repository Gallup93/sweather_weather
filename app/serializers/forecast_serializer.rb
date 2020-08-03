class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :general, :current, :hourly, :daily
end
