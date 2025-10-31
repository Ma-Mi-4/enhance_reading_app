require "test_helper"

class Admin::MainControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_main_index_url
    assert_response :success
  end
end
