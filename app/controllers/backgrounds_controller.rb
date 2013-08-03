class BackgroundsController < ApplicationController
  def index
    @backgrounds = Background.all
  end

  def new
    @background = Background.new
  end
  
  def create
    @background = Background.create( params[:background] )
  end
end
