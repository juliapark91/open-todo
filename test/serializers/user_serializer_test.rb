require 'test_helper'

class UserSerializerTest < ActiveSupport::TestCase

  test 'UserSerializer returns JSON representation of a User' do

    assert_equal "{\"user\":{\"id\":null,\"username\":null,\"password\":null}}", UserSerializer.new(User.new).to_json
  
  end

end