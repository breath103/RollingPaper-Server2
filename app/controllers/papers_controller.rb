class PapersController < ApplicationController
  # before_filter :require_login
  # private
  #  def require_login
  #    if session[:current_user_id] 
  #      ap 
  #    else
  #      flash[:error] = "You must be logged in to access this section"
  #      redirect_to "logins/sign_in"
  #    end
  #  end
  
  def index
    @papers = Paper.all
  end

  def show 
    @paper = Paper.find_by_id(params[:id])
    if(@paper.state != "opened")
      @paper.send_feedback_to_participants "이나연 님이 #{@paper.title}를 보셨습니다"
      @paper.state = "opened"
      @paper.save!
    end
    render layout: false
  end 
end
