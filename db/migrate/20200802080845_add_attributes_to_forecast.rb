class AddAttributesToForecast < ActiveRecord::Migration[5.2]
  def change
    add_column :forecasts, :general, :text
    add_column :forecasts, :current, :text
    add_column :forecasts, :hourly, :text
    add_column :forecasts, :daily, :text
    remove_column :forecasts, :metadata
  end
end
