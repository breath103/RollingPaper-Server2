class AdminNotificationsController < ApplicationController
  def index
    @notifications = Notification.all
  end
end
