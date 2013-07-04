class PapersController < ApplicationController
  def index
    @papers = Paper.all
  end
  def show 
    @paper = Paper.find_by_id(params[:id])
    render layout: false
  end 
end
