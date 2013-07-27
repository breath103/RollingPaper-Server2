class AdminNotificationsController < ApplicationController
  def new
  
  end 
  
  def create
    n = Notification.create(params[:notification])
    redirect_to :index
  end

  def index
    @notifications = Notification.all
  end
end
