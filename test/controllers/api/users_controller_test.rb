require 'test_helper'

class Api::UsersControllerTest < ActionController::TestCase
  
  test 'should get index' do
    get :index
  end
  
end
