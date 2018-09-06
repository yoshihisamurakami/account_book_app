require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin_user = users(:admin)
    @user = users(:murakami)
  end
  
  test "管理者以外はアクセスできないこと" do
    get new_user_path
    assert_redirected_to login_url
  end

  test "一般ユーザーはアクセスできないこと" do
    log_in_as(@user)
    get new_user_path
    assert_redirected_to root_url    
  end
  
  test "管理者ユーザーはアクセスできること" do
    log_in_as(@admin_user)
    get new_user_path
    assert_response :success
    assert_select 'title', '新規ユーザー作成 - 家計簿App'    
  end
end
