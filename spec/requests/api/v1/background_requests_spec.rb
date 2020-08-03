require 'rails_helper'
describe "expose ReST end points" do
  context "a user searches for a related background" do

    it "returns a related image URL" do
      denver_image_request = File.read("spec/fixtures/denver_background.json")

      stub_request(:get, "http://localhost:3000/backgrounds?location=denver,co").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v1.0.1'
        }).
      to_return(status: 200, body: denver_image_request, headers: {})

      conn = Faraday.new(url: "http://localhost:3000/api/v1/")
      response = conn.get("/backgrounds?location=denver,co")
      image_url = JSON.parse(response.body, symbolize_names: true)
      expected = ({"url": "https://images.unsplash.com/photo-1588143140762-5b23b6b43532?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjE1NDAzNn0"})

      expect(image_url).to eq(expected)
    end
  end
end
