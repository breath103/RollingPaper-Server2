class UsersController < ApplicationController
  def home
    @me = current_user
  end
end
