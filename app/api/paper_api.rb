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
      Background.all.collect { |b| b.image.url(:original) }
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
