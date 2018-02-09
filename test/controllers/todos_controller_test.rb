require 'test_helper'

class TodosControllerTest < ActionDispatch::IntegrationTest
  test "should get items" do
    get todos_items_url
    assert_response :success
  end

end
