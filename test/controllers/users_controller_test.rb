require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "新規ユーザー作成画面にアクセスできること" do
    get new_user_path
    assert_response :success
    assert_select 'title', '新規ユーザー作成 - 家計簿App'
  end

end
