require 'test_helper'

module API

  class UsersControllerTest < ActionDispatch::IntegrationTest
    
    #
    # curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" -d '{"user":{"email":"someone@example.com","password":"password"}}' http://localhost:3000/api/users
    #

    test "POST /users should create user with valid email and valid password" do

      assert_difference( 'User.count' ) do
        post '/api/users', 
          { user: 
            { email: 'someone@example.com', password: 'password' }
          }.to_json,
          { 'Accept': Mime::JSON, 'Content-Type': Mime::JSON.to_s }
      end

      assert_equal 201, response.status
      assert_equal Mime::JSON, response.content_type
      
      response_message = json( response.body )
      assert_equal( { success: "user sucessfully created" }, response_message )
    end
    
    #
    # curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" -d '{"user":{"email":"someone@example.com", "password":""}}' http://localhost:3000/api/users
    #

    test "POST /users should not create user with valid email and invalid password" do
      assert_no_difference( 'User.count' ) do
        post '/api/users', 
          { user: 
            { email: 'someone@example.com', password: nil }
          }.to_json,
          { 'Accept': Mime::JSON, 'Content-Type': Mime::JSON.to_s }
      end

      assert_equal 422, response.status
      assert_equal Mime::JSON, response.content_type
      
      response_message = json( response.body )
      assert_equal( { failure: "invalid e-mail or password" }, response_message )
    end
    
    #
    # curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" -d '{"user":{"email": "", "password":"password"}}' http://localhost:3000/api/users
    #

    test "POST /users should not create user with an invalid email and valid password" do
      assert_no_difference( 'User.count' ) do
        post '/api/users', 
          { user: 
            { email: nil, password: 'password' }
          }.to_json,
          { 'Accept': Mime::JSON, 'Content-Type': Mime::JSON.to_s }
      end

      assert_equal 422, response.status
      assert_equal Mime::JSON, response.content_type
      
      response_message = json( response.body )
      assert_equal( { failure: "invalid e-mail or password" }, response_message )
    end
    
    #
    # curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" -d '{"user":{"email":"","password":""}}' http://localhost:3000/api/users
    #

    test "POST /users should not creates user with invalid email and valid password" do
      assert_no_difference( 'User.count' ) do
        post '/api/users', 
          { user: 
            { email: nil, password: nil }
          }.to_json,
          { 'Accept': Mime::JSON, 'Content-Type': Mime::JSON.to_s }
      end

      assert_equal 422, response.status
      assert_equal Mime::JSON, response.content_type
      
      response_message = json( response.body )
      assert_equal( { failure: "invalid e-mail or password" }, response_message )
    end
    
    #
    # WIP:  This test does not take into account that you'll need both email and password
    #       attributes.  Thus, this is left as an exercise for you.  Remove this comment 
    #       when the required functionality has been included within the test.
    #
        
    test "GET /users should retrieve all users" do
      user_emails = %w[ user1@example.com user2@example.com ]
      
      user_emails.each do | user_email |  
        post '/api/users', 
          { user: 
            { email: user_email, password: 'password' }
          }.to_json,
          { 'Accept': Mime::JSON, 'Content-Type': Mime::JSON.to_s }
        
        assert_equal 201, response.status
        assert_equal Mime::JSON, response.content_type
      end
      
      get '/api/users'

      assert_equal 200, response.status
      assert_equal Mime::JSON, response.content_type
      
      assert_equal user_emails, assigns(:users).map(&:email)
    end
    
  end

end
