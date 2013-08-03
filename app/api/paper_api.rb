class PaperAPI < Grape::API
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
      paper_params = params.slice( :creator_id, :title, :width, :height, :notice, :receive_time, :created_time, :friend_facebook_id, :recipient_name, :background );
      paper = Paper.new(paper_params)
      paper.state = "editing"

      if paper.valid?
        paper.save
        
        ticket = Ticket.new
        ticket.user_id = paper.creator_id
        ticket.paper_id = paper.id
        ticket.save
        
        present paper, source: "paper"
      else
        error!({ error: paper.errors.full_messages }, 400)
      end
    end

    get '/:id', :rabl => "paper" do 
      @paper = Paper.find_by_id(params[:id])
    end
    
    get '/:id/participants' do 
      paper = Paper.find_by_id(params[:id])
      present paper.participants, source: "user"
    end
    
    get '/:id/invitations' do 
      paper = Paper.find_by_id(params[:id])
      present paper.invitations, source: "invitation"
    end

    put '/:id' do
      paper = Paper.find_by_id(params[:id])
      paper_params = params.slice( :creator_id, :title, :width, :height, :notice, :receive_time, :friend_facebook_id, :recipient_name, :background );
      ap paper_params
	    paper.update_attributes(paper_params)
      paper
    end

    post '/:id/feedback' do
      ap params[:id] 
      ap params[:feedback]
      if params[:id] && params[:feedback]
        paper = Paper.find_by_id(params[:id])
        PaperFeedbackNotificationWorker.perform_async(paper.id, params[:feedback])
      end
    end
    
    get '/:id/contents', rabl: "paper-contents" do 
      paper = Paper.find_by_id(params[:id])
      @paper = paper
      @contents = paper.contents
    end
  end
  
end
