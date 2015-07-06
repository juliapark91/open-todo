require 'test_helper'

class UserSerializerTest < ActiveSuppoer::TestCase

  test 'UserSerializer returns JSON representation of a User' do

    assert_equal "{\"id\":null,\"created_at\":null,\"updated_at\":null}", UserSerializer.new(User.new).to_json
  
  end

end