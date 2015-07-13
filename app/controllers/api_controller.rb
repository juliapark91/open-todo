class APIController < ApplicationController 
  
  skip_before_action :verify_authenticity_token
  
  def authenticated?
    authenticate_or_request_with_http_basic {| username, password | User.where( username: username, password: password ).present? }
  end

end
