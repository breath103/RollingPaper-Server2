require "awesome_print"
class API < Grape::API
  format :json
  default_format :json
  formatter :json, Grape::Formatter::Rabl
  content_type :json, "application/json; charset=utf-8"
  mount UserAPI
  mount PaperAPI
  mount SoundContentsAPI
  mount ImageContentsAPI
  mount InvitationAPI
end
