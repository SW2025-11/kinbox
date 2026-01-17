require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    post login_path, params: {
      email: @user.email,
      password: "password"
    }
  end

  test "should get index" do
    get favorites_path
    assert_response :success
  end
end