require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:admin)
    @user = users(:murakami)
  end
  
  test "間違った情報でログインすると、エラーになること" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "正しい情報でログインできること" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/home'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    #assert_select "a[href=?]", user_path(@user)
  end
  
  test "管理者ユーザーでログインしたときのレイアウト" do
    log_in_as(@admin_user)
    get root_url
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", '#', text: "管理者用"
    assert_select "a[href=?]", users_path, text: "ユーザー一覧"
    #assert_select "a[href=?]", '#', text: "口座一覧"
    #assert_select "a[href=?]", '#', text: "カテゴリ一覧"
  end
end
