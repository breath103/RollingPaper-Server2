class AdminController < ApplicationController
  def show 
  end
  def index
    @admins = Admin.all
  end
end
