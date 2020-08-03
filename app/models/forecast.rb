class Forecast < ApplicationRecord
  serialize :general, JSON
  serialize :current, JSON
  serialize :hourly, JSON
  serialize :daily, JSON
end
