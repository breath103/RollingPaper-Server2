class ImageContentsAPI < Grape::API
  format :json
  default_format :json
  formatter :json, Grape::Formatter::Rabl
  content_type :json, "application/json; charset=utf-8"

  resource :image_contents do
# implemented in image contents controller
# post '/' do 
# end 
    get '/:id' do 
      ImageContent.find_by_id(params[:id])
    end
    
    put '/:id' do 
      image_params = params.slice(:user_id, :paper_id, :x, :y ,:width, :height, :rotation)
      image_content = ImageContent.find_by_id(params[:id])
      image_content.update_attributes(image_params)
      image_content
    end
    
    delete '/:id' do 
      image_content = ImageContent.find_by_id(params[:id])
      image_content.delete
    end

  end

end
