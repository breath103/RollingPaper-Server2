class BackgroundsController < ApplicationController
  def index
    @backgrounds = Background.all
  end

  def new
    @background = Background.new
  end
  
  def destroy 
    background = Background.find(params[:id])
    background.delete
    redirect_to "/backgrounds"
  end
  
  def create
    @background = Background.create( params[:background] )
    redirect_to "/backgrounds"
  end
end
