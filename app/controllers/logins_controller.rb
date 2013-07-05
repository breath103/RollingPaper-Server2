class LoginsController < ApplicationController
  def sign_in_with_facebook
    if params[:facebook_id]
      user = User.find_by_facebook_id(params[:facebook_id])
      if !user
        user = User.new({facebook_id: params[:facebook_id]})
        user.save
      end
      session[:current_user_id] = user.id
      print "SADGASDFADSSDF#{session[:current_user_id]}"
      render json: user
    else 
      render json: {}
    end
  end
end

