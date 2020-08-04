class ApplicationController < ActionController::API
  def  find_user_by_email(email)
    User.find_by(email: email)
  end
end
