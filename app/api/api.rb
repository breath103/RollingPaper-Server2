class API < Grape::API
  format :json
  default_format :json
#  formatter :json, Grape::Formatter::Rabl
  content_type :json, "application/json; charset=utf-8"

  resource :users do
    post '/' do
      
    end
    get ':username' do
      user = User.find_by_username(params[:username]) if params[:username]
      user ? user.to_json : nil
    end
  end
end
