require 'test_helper'

class UserLoginControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get user_login_login_url
    assert_response :success
  end

  test "should get auth" do
    get user_login_auth_url
    assert_response :success
  end

  test "should get logout" do
    get user_login_logout_url
    assert_response :success
  end

end
