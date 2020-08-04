require 'rails_helper'

describe "expose ReST end points" do
  it "validates user through login" do
    post '/api/v1/users?email=turing@aol.com&password=password&password_confirmation=password'
    user = User.last
    post "/api/v1/sessions?email=#{user.email}&password=password"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(json[:type]).to eq("users")
    expect(json[:attributes][:email]).to eq(user.email)
    expect(json[:attributes][:api_key]).to eq(user.api_key)
  end

  it "doesn't allow invalid credentials" do
    post '/api/v1/users?email=turing@aol.com&password=password&password_confirmation=password'
    user = User.last
    post "/api/v1/sessions?email=#{user.email}&password=password1234"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(json).to eq(["invalid credentials"])

    post '/api/v1/users?email=turing@aol.com&password=password&password_confirmation=password'
    user = User.last
    post "/api/v1/sessions?email=FakeEmail@aol.com&password=password1234"
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(json).to eq(["invalid credentials"])
  end
end
