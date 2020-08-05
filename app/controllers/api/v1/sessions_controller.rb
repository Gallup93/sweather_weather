class Api::V1::SessionsController < ApplicationController
   def create
     user = find_user_by_email(params[:email])

     if user && user.authenticate(params[:password])
       response = {type: "users", id: user.id, attributes: {email: user.email, api_key: user.api_key}}
       render json: response
     else
       response = ["invalid credentials"]
       render json: response, status: :bad_request
     end
   end
end
