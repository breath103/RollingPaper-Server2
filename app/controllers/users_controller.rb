require "awesome_print"
class UsersController < ApplicationController
  def home
    @me = current_user
    ap @me
    render layout: false
  end
end
