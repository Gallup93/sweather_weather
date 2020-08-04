require 'rails_helper'
describe "expose ReST end points" do
  context "a user searches for a related background" do
    it "returns a related image URL", :vcr do
      conn = Faraday.new(url: "http://localhost:3000/api/v1/")
      response = conn.get("backgrounds?location=denver,co")

      expect(response.status).to eq(200)

      image_json = JSON.parse(response.body, symbolize_names: true)
      url = image_json[:url]

      expect(url.include?("https://images.unsplash.com/")).to eq(true)
    end
  end
end
