class InvitationAPI < Grape::API
  format :json
  default_format :json
  formatter :json, Grape::Formatter::Rabl
  content_type :json, "application/json; charset=utf-8"
  
  resource :invitations do
    post "/" do
      invitation_params = params.slice(:sender_id, :paper_id, :friend_facebook_id)
      ap invitiaton_params
      i = Invitation.new(invitation_params)
      i.save
      i
    end

    post "/:id/accept" do
      invitation = Invitation.find(params[:id])
      if invitation
        invitation.accept 
      end
    end
    
    delete "/:id/reject" do
      invitation = Invitation.find(params[:id])
      if invitation
        invitation.reject
      end
    end
  end
end
