class ImageContentsController < ApplicationController
  respond_to :json
  def create
    image_params = params.slice(:user_id, :paper_id, :x, :y ,:width, :height, :rotation, :image)
    @contents = ImageContent.create(image_params)
    respond_with(@contents)
  end
end
