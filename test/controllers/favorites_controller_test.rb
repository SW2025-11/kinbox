require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get favorites_path
    assert_response :success
  end
end

