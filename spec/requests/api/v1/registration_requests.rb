require 'rails_helper'

describe "expose ReST end points" do
    it "can create a new user", :vcr do
      post '/api/v1/users?email=turing@aol.com&password=password&password_confirmation=password'

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(201)
    end
  end
