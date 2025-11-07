require "test_helper"

class RubyHomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ruby_home_index_url
    assert_response :success
  end
end
