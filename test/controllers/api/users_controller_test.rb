require 'test_helper'

module API

  class UsersControllerTest < ActionDispatch::IntegrationTest
    
    setup do
      # set up authentication for a single user
      @user = users(:valid_username_valid_password)
      @username = @user.username
      @password = @user.password
      basic = ActionController::HttpAuthentication::Basic
      @credentials = basic.encode_credentials( @username, @password )
      @accept_json_header = { 'Accept': Mime::JSON, 'Content-Type': Mime::JSON.to_s }
      @auth_header = { 'Authorization' => @credentials }
    end
    
    #
    # curl -u someone@example.com:password -X POST -H "Accept: application/json" -H "Content-Type: application/json" -d "user[username]=user1@example.com" -d "user[password]=password" http://localhost:3000/api/users
    #

    test "POST /users should create user with valid username and valid password" do

      assert_difference( 'User.count' ) do
        post '/api/users', 
          { user: 
            { username: 'user1@example.com', password: 'password' }
          }.to_json,
          @accept_json_header.merge(  @auth_header )
      end

      assert_equal 201, response.status
      assert_equal Mime::JSON, response.content_type
      
      response_message = json( response.body )
      assert_equal( { success: "user sucessfully created" }, response_message )
    end
    
    #
    # curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" -d "user[username]=user1@example.com" -d "user[password]=" http://localhost:3000/api/users
    #

    test "POST /users should not create user with valid username and invalid password" do
      assert_no_difference( 'User.count' ) do
        post '/api/users', 
          { user: 
            { username: 'user1@example.com', password: nil }
          }.to_json,
          @accept_json_header.merge(  @auth_header )
      end

      assert_equal 422, response.status
      assert_equal Mime::JSON, response.content_type
      
      response_message = json( response.body )
      assert_equal( { failure: "invalid username or password" }, response_message )
    end
    
    #
    # curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" -d "user[username]=" -d "user[password]=password" http://localhost:3000/api/users
    #

    test "POST /users should not create user with an invalid username and valid password" do
      assert_no_difference( 'User.count' ) do
        post '/api/users', 
          { user: 
            { username: nil, password: 'password' }
          }.to_json,
          @accept_json_header.merge(  @auth_header )
      end

      assert_equal 422, response.status
      assert_equal Mime::JSON, response.content_type
      
      response_message = json( response.body )
      assert_equal( { failure: "invalid username or password" }, response_message )
    end
    
    #
    # curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" -d "user[username]=" -d "user[password]=" http://localhost:3000/api/users
    #

    test "POST /users should not creates user with invalid username and valid password" do
      assert_no_difference( 'User.count' ) do
        post '/api/users', 
          { user: 
            { username: nil, password: nil }
          }.to_json,
          @accept_json_header.merge( @auth_header )
      end

      assert_equal 422, response.status
      assert_equal Mime::JSON, response.content_type
      
      response_message = json( response.body )
      assert_equal( { failure: "invalid username or password" }, response_message )
    end
    
    #
    # $ curl -u someone@example.com:password -d "user[username]=user1@example.com" -d "user[password]=password" http://localhost:3000/api/users/
    # $ curl -u someone@example.com:password -d "user[username]=user2@example.com" -d "user[password]=password" http://localhost:3000/api/users/
    #
    
    test "GET /users should retrieve all users" do
      # create some users
      
      credentials = [ { username: 'user1@example.com', password: 'password' }, { username: 'user2@example.com', password: 'password' } ]
      
      credentials.each do | credential |  
        post '/api/users/', 
          { user: 
            credential
          }.to_json,
          @accept_json_header.merge( @auth_header )
        
        assert_equal 201, response.status
        assert_equal Mime::JSON, response.content_type
      end

      # retrieve the list of users
      get '/api/users', {}, @accept_json_header.merge( @auth_header )

      assert_equal 200, response.status
      assert_equal Mime::JSON, response.content_type
      
      # verify that all users that were created are returned
      usernames = credentials.map { | credential| credential[:username] }

      usernames.each do | username |
        assert_includes assigns(:users).map(&:username), username
      end
    end
    
  end

end
