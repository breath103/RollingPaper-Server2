class PapersController < ApplicationController

  def index
    @papers = Paper.all
  end

  def show 
    @paper = Paper.find_by_id(params[:id])
    if(@paper && @paper.state != "opened")
      @paper.state = "opened"
      @paper.save!
    else 

    end
    render layout: false
  end 
end
