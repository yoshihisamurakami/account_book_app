require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test "ログイン画面が表示されること" do
    get login_path
    assert_response :success
  end

end
