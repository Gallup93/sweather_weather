require 'rails_helper'

describe "expose ReST end points" do
    it "can create a new user", :vcr do
      post '/api/v1/users?email=turing@aol.com&password=password&password_confirmation=password'

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(201)
      expect(json[:data].keys).to eq([:id,:type,:attributes])
      expect(json[:data][:type]).to eq("users")
      expect(json[:data][:attributes][:email]).to eq("turing@aol.com")
      expect(json[:data][:attributes][:api_key].length).to eq(30)
    end

    it "cannot create a new user with invalid data", :vcr do
      post '/api/v1/users?email=turing@aol.com&password=password&password_confirmation=passsword'

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(json).to eq(["Password confirmation doesn't match Password"])

      post '/api/v1/users?email=turing@aol.com&password=password&password_confirmation=password'

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(201)
      expect(json[:data][:attributes][:email]).to eq("turing@aol.com")

      post '/api/v1/users?email=turing@aol.com&password=password&password_confirmation=passwordd'

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response.status).to eq(400)
      expect(json).to eq(["Email has already been taken", "Password confirmation doesn't match Password"])
    end
  end
