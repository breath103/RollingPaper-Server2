class UserAPI < Grape::API
  format :json
  default_format :json
  formatter :json, Grape::Formatter::Rabl
  content_type :json, "application/json; charset=utf-8"
  
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
        user = User.create(user_params)
      else 
        user.update_attributes(user_params)
      end
      user
    end 
    
    get '/' do
      User.all
    end
    
    # "users/%d/received_papers.json",[self id]]
    # "users/%d/participating_papers.json",[self id]]
    # "users/%d/created_papers.json",[self id]]
    get '/:id/participating_papers', :rabl => "papers"  do
      user = User.find_by_id(params[:id])
      @papers = user.papers
    end
    
    get '/:id/received_papers', :rabl => "papers" do
      user = User.find_by_id(params[:id])
      @papers = user.received_papers
    end
    
    get '/:id/sended_papers', :rabl => "papers" do
      user = User.find_by_id(params[:id])
      @papers = user.sended_papers
    end
    
    get '/:id/notifications' do
      user = User.find_by_id(params[:id])
      user.notifications#.order("created_at DESC")
    end
    
    delete '/:id/papers/:paper_id' do 
      user  = User.find_by_id(params[:id])
      paper = Paper.find_by_id(params[:paper_id])
      user.tickets.where("paper_id = #{paper.id}").delete_all
      if (paper.creator_id == user.id) 
        paper.participants.each { |u|
          n = Notification.create({
            sender: user,
            recipient: u,
            notification_type: "paper_deleted",
            source_id: paper.id,
            picture: u.picture,
            text: "#{user.username}님이 #{paper.title} 페이퍼를 삭제하였습니다"
          })
          MobileNotificationSender.perform_async(n.id)
        }
        paper.delete
      end
    end
    
    get '/:id' do
      User.find_by_id(params[:id])
    end
    
    post '/:id/invite_friends' do
      invitor = User.find_by_id(params[:id])
      if params[:friends] && params[:paper_id]
        params[:friends].each { |user|
          invitation = Invitation.create({sender_id: invitor.id, 
                                          friend_facebook_id: user.id,
                                          receiver_name: user.name,
                                          receiver_picture: user.picture.data.url,
                                          paper_id: params[:paper_id]})
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
