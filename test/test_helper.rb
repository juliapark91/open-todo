ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/autorun'
require 'minitest/reporters'
require 'capybara/rails'
require 'capybara/poltergeist'

Dir[Rails.root.join( "test/support/**/*" )].each { |f| require f }

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(:color => true)]

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers
  
  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  include TestAPIHelper

  # Add more helper methods to be used by all tests here...
  def setup
    # Capybara.current_driver = Capybara.javascript_driver # :selenium by default
    # Capybara.current_driver = :webkit
    Capybara.current_driver = :poltergeist
  end

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
  
  def sign_up( email, password )
    visit root_path

    click_link 'Sign Up'

    fill_in 'First name', with: Faker::Name.first_name
    fill_in 'Last name', with: Faker::Name.last_name
    fill_in 'Email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password

    click_button 'Sign Up'
  end

  def sign_in( email, password )
    visit root_path

    click_link 'Sign In'

    fill_in 'Email', with: email
    fill_in 'Password', with: password

    click_button 'Sign In'
  end

  def sign_out
    click_link 'Sign Out'
  end
  
end
