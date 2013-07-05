class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user
    if session[:current_user_id]
      User.find_by_id(session[:current_user_id]) 
    else 
      nil
    end
  end
end
