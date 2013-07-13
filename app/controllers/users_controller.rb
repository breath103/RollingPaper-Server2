require "awesome_print"
class UsersController < ApplicationController
  def home
    @me = current_user
    render layout: false
  end
end
