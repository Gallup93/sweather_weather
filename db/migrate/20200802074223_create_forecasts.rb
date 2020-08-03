class CreateForecasts < ActiveRecord::Migration[5.2]
  def change
    create_table :forecasts do |t|
      t.string :metadata
      t.timestamps null: false
    end
  end
end
