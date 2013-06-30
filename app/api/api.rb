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
        "http://www.hdwallpapersbest.com/wp-content/uploads/2013/01/colorful_background-wide1.jpg",
        "http://us.123rf.com/400wm/400/400/aparagraph/aparagraph1103/aparagraph110300057/9109200-ripped-striped-background.jpg",
        "http://downloads.xdesktopwallpapers.com/wp-content/uploads/2012/04/3d%20Colorful%20Squares%20On%20Black%20Background.jpg",
      ]
    end
    
    post '/' do
      paper_params = params.slice( :creator_id, :title, :width, :height, :notice, 
                                   :receive_time, :created_time, :friend_facebook_id, :background );
      paper = Paper.new(paper_params)
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
      paper
    end
    
    get '/:id/contents', rabl: "paper-contents.rabl" do 
      paper = Paper.find_by_id(params[:id])
      @paper = paper
      @contents = paper.contents
    end
    
    post '/:paper_id/image_contents' do 
      paper = Paper.find_by_id(params[:paper_id]) 
      ap params
      image_content = ImageContent.create(params[:image_content])
      image_content
    end
    
    get '/:paper_id/image_contents/:image_id' do 
      paper = Paper.find_by_id(params[:paper_id])
      image_content = ImageContent.find_by_id(params[:image_id])
      image_content
    end

    put '/:paper_id/image_contents/:image_id' do 
      paper = Paper.find_by_id(params[:paper_id])
    end
  end
  
  resource :users do
    get '/' do
      User.all
    end
    
    post '/auth' do
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

    get '/:id', :rabl => 'user' do
      @user = User.find_by_id(params[:id]) if params[:id]
    end
    
    # "users/%d/received_papers.json",[self id]]
    # "users/%d/participating_papers.json",[self id]]
    # "users/%d/created_papers.json",[self id]]
    
    get '/:id/participating_papers' do
      user = User.find_by_id(params[:id])
      user.papers
    end
  end
end
