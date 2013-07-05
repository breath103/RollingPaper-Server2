require "awesome_print"
class API < Grape::API
  format :json
  default_format :json
  formatter :json, Grape::Formatter::Rabl
  content_type :json, "application/json; charset=utf-8"

  resource :papers do
    get '/' do
      Paper.all
    end

    get '/backgrounds' do
      [
        "http://t2.gstatic.com/images?q=tbn:ANd9GcShrXNxT0JaIpDVN7wP_il0dEBo4IBkqdXjChDS8uvL7cWHZV7g",
        "http://t3.gstatic.com/images?q=tbn:ANd9GcQ_iMlY9xR6v79AwuiGIB0va2cJ8TTpbgTBV3tKzmI8vF1xgyRc",
        "http://th09.deviantart.net/fs71/200H/i/2011/258/a/3/stone_texture_10___seamless_by_agf81-d49w3l3.jpg"
      ]
    end
    
    post '/' do
      paper_params = params.slice( :creator_id, :title, :width, :height, :notice, 
                                   :receive_time, :created_time, :friend_facebook_id, 
                                   :background );
      paper = Paper.new(paper_params)
      paper.state = "editing"
      paper.save
      ticket = Ticket.new
      ticket.user_id = paper.creator_id
      ticket.paper_id = paper.id
      ticket.save
      paper
    end

    get '/:id' do 
      paper = Paper.find_by_id(params[:id])
      paper
    end
    
    put '/:id' do
      paper = Paper.find_by_id(params[:id])
      paper_params = params.slice( :creator_id, :title, :width, :height, :notice, :receive_time, :friend_facebook_id, :background );
      ap paper_params
	    paper.update_attributes(paper_params)
      paper
    end
    
    get '/:id/contents', rabl: "paper-contents.rabl" do 
      paper = Paper.find_by_id(params[:id])
      @paper = paper
      @contents = paper.contents
    end
  end
  
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
  
  resource :invitation do
    post "/" do
      invitation_params = params.slice(:sender_id, :paper_id, :friend_facebook_id)
      ap invitiaton_params
      i = Invitation.new(invitation_params)
      i.save
      i
    end
  end
  
  resource :users do
    post '/authorize' do
      user_params = params.slice(
         :username,
         :name, 
         :email, 
         :birthday,
         :password, 
         :picture,
         :facebook_id,
         :facebook_accesstoken
      );
      user = User.find_by_facebook_id(user_params[:facebook_id]) if user_params[:facebook_id]
      if !user
        user = User.new(user_params)
        user.save
      end
      user
    end 
    
    get '/' do
      User.all
    end
    # "users/%d/received_papers.json",[self id]]
    # "users/%d/participating_papers.json",[self id]]
    # "users/%d/created_papers.json",[self id]]
    get '/:id/participating_papers' do
      user = User.find_by_id(params[:id])
      user.papers
    end
    
    get '/:id' do
      User.find_by_id(params[:id])
    end
    
    post '/:id/invite_friends' do
      user = User.find_by_id(params[:id])
      if params[:friends] && params[:paper_id]
        params[:friends].each { |fb_id|
          invitation = Invitation.new({sender_id: user.id,friend_facebook_id: fb_id,paper_id: params[:paper_id]})
          ap invitation
          invitation.save
        }
      end
      
    end
    
    post '/:id/apn_key' do
      user = User.find_by_id(params[:id])
      user.apn_key = params[:apn_key]
      user.save
      user
    end
    
  end
end
