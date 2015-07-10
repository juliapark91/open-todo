require 'test_helper'

class API::UsersControllerTest < ActionController::TestCase

  test 'should create user' do
    assert_difference( 'User.count' ) do 
      
      post :create, user: { email: 'julia@example.com', password: '123456' }.to_json,

        {'Accept': Mime::JSON, 'Content-Type': Mime::JSON.to_s}
    end

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
  end

  # test 'should not create user with invalid email' do
  #   assert_no_difference( 'User.count' ) do 
  #     get :index,
  #       { user: 
  #         { email: '',
  #           password: '123456' }
  #       }.to_json,
  #       {'Accept': Mime::JSON, 'Content-Type': Mime::JSON.to_s, "Origin": UserSerializer}
  #   end

  #   assert_equal 201, response.status
  #   assert_equal Mime::JSON, response.content_type
  # end

  # test 'should not create user with invalid password' do
  #   assert_difference( 'User.count' ) do 
  #     get :index,
  #       { user: 
  #         { email: 'julia@example.com',
  #           password: '' }
  #       }.to_json,
  #       {'Accept': Mime::JSON, 'Content-Type': Mime::JSON.to_s, "Origin": UserSerializer}
  #   end

  #   assert_equal 201, response.status
  #   assert_equal Mime::JSON, response.content_type
  # end

end
