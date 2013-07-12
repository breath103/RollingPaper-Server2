class InvitationAPI < Grape::API
  format :json
  default_format :json
  formatter :json, Grape::Formatter::Rabl
  content_type :json, "application/json; charset=utf-8"

  resource :invitation do
    post "/" do
      invitation_params = params.slice(:sender_id, :paper_id, :friend_facebook_id)
      ap invitiaton_params
      i = Invitation.new(invitation_params)
      i.save
      i
    end
  end

end
