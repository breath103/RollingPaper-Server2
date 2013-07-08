require "awesome_print"
class API < Grape::API
  format :json
  default_format :json
  formatter :json, Grape::Formatter::Rabl
  content_type :json, "application/json; charset=utf-8"

  mount UserAPI
  mount PaperAPI

  #   resource :sound_contents do
  #     get '/:id' do 
  #       SoundContent.find_by_id(params[:id])
  #   end
  #      
  #     put '/:id' do 
  #     sound_params = params.slice(:user_id, :paper_id, :x, :y ,:width, :height, :rotation)
  #     sound_content = SoundContent.find_by_id(params[:id])
  #     sound_content.update_attributes(sound_params)
  #     sound_content
  #   end
  #     
  #     delete '/:id' do 
  #       image_content = ImageContent.find_by_id(params[:id])
  #        image_content.delete
  #     end
  #   end
  #   
  #   resource :image_contents do
  # # implemented in image contents controller
  # # post '/' do 
  # # end 
  #     get '/:id' do 
  #       ImageContent.find_by_id(params[:id])
  #     end
  #     
  #     put '/:id' do 
  #       image_params = params.slice(:user_id, :paper_id, :x, :y ,:width, :height, :rotation)
  #       image_content = ImageContent.find_by_id(params[:id])
  #       image_content.update_attributes(image_params)
  #       image_content
  #     end
  #     
  #     delete '/:id' do 
  #       image_content = ImageContent.find_by_id(params[:id])
  #       image_content.delete
  #     end
  #   end
  #   
  #   resource :invitation do
  #     post "/" do
  #       invitation_params = params.slice(:sender_id, :paper_id, :friend_facebook_id)
  #       ap invitiaton_params
  #       i = Invitation.new(invitation_params)
  #       i.save
  #       i
  #     end
  #   end
end
