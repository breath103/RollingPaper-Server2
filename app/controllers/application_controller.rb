class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # def redirect_to_facebook_login
  #   redirect_to "https://www.facebook.com/dialog/oauth?client_id={app-id}&redirect_uri={redirect-uri}"
  #   return
  # end

  def current_user
    if session[:current_user_id]
      User.find_by_id(session[:current_user_id]) 
    else 
      nil
    end
  end
end
