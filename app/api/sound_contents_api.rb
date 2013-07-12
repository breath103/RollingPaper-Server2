class SoundContentsAPI < Grape::API
  format :json
  default_format :json
  formatter :json, Grape::Formatter::Rabl
  content_type :json, "application/json; charset=utf-8"

  resource :sound_contents do
    
    get '/:id' do 
      SoundContent.find_by_id(params[:id])
    end
    
    put '/:id' do 
      sound_params = params.slice(:user_id, :paper_id, :x, :y ,:width, :height, :rotation)
      sound_content = SoundContent.find_by_id(params[:id])
      sound_content.update_attributes(sound_params)
      sound_content
    end
    
    delete '/:id' do 
      image_content = ImageContent.find_by_id(params[:id])
       image_content.delete
    end
    
  end
end
