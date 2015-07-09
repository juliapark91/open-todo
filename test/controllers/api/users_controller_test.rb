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
    
  end

end
