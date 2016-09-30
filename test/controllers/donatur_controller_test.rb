require 'test_helper'

class DonaturControllerTest < ActionDispatch::IntegrationTest
  test "should get register" do
    get donatur_register_url
    assert_response :success
  end

  test "should get post_login" do
    get donatur_post_login_url
    assert_response :success
  end

end
