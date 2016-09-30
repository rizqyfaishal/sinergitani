require 'test_helper'

class KelompokTaniControllerTest < ActionDispatch::IntegrationTest
  test "should get post_login" do
    get kelompok_tani_post_login_url
    assert_response :success
  end

end
