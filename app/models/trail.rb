class Forecast < ApplicationRecord
  serialize :attributes, JSON
end
