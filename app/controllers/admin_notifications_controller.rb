class AdminNotificationsController < ApplicationController
  def new
  
  end 
  
  def create
    @notification = AdminNotification.new(notification_params)
    @notification.save
    redirect_to :index
  end

  def index
    @notifications = AdminNotification.all
  end

  private
    def notification_params
      params.require(:admin_notification)
    end
end
