require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin_user = users(:admin)
    @user = users(:murakami)
  end
  
  test "未ログイン状態でユーザー一覧ページを開いたらリダイレクトされること" do
    get users_path
    assert_redirected_to login_url
  end
  
  test "一般ユーザーで閲覧できないこと" do
    log_in_as(@user)
    get users_path
    assert_redirected_to root_url
  end
  
  test "ユーザー一覧ページが正常であること" do
    log_in_as(@admin_user)
    get users_path
    assert_template 'users/index'
    
    User.all.each do |user|
      assert_select 'td', text: user.name
      assert_select 'a[href=?]', edit_user_path(user), text: "編集"
    end
  end
end
