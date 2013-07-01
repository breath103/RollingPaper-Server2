require 'awesome_print'
class SoundContentsController < ApplicationController
  respond_to :json
  def create
    sound_params = params.slice(:user_id, :paper_id, :x, :y ,:width, :height, :rotation, :sound)
    @contents = SoundContent.create(sound_params)
    respond_with(@contents)
  end
end
