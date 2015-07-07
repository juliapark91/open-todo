require 'test_helper'

class ItemSerializerTest < ActiveSupport::TestCase

  test 'ItemSerializer returns JSON representation of an Item' do

    assert_equal "{\"item\":{\"id\":null,\"name\":null}}", ItemSerializer.new(Item.new).to_json
  
  end

end