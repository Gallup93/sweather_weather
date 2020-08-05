class ApplicationController < ActionController::API
  def  find_user_by_email(email)
    User.find_by(email: email)
  end
  def  find_user_by_api_key(key)
     User.find_by(api_key: key)
  end
end
