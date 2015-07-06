require 'test_helper'

class ListSerializerTest < ActiveSupport::TestCase

  test 'ListSerializer returns JSON representation of a List' do

    assert_equal "{\"list\":{\"id\":null,\"name\":null}}", ListSerializer.new(List.new).to_json
  
  end

end