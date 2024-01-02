require "test_helper"

class HelperBotControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get helper_bot_index_url
    assert_response :success
  end
end
