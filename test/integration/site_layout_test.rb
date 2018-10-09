require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:admin)
    @user = users(:murakami)
  end
  
  test "管理者でログインしたときのレイアウトが正常であること" do
    log_in_as(@admin_user)
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, text: 'Home'
    assert_select 'a[href=?]', '#', text: '管理者用'
    assert_select 'a[href=?]', users_path, text: 'ユーザー一覧'
    assert_select 'a[href=?]', accounts_path, text: '口座一覧'
    assert_select 'a[href=?]', categories_path, text: 'カテゴリ一覧'
    assert_select 'a[href=?]', help_path, text: 'ヘルプ'
    assert_select 'a[href=?]', logout_path, text: 'ログアウト'
  end
  
  test "一般ユーザーでログインしたときのレイアウトが正常であること" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, text: 'Home'
    assert_select 'a[href=?]', '#', text: '管理者用', count: 0
    assert_select 'a[href=?]', users_path, text: 'ユーザー一覧', count: 0
    assert_select 'a[href=?]', accounts_path, text: '口座一覧', count: 0
    assert_select 'a[href=?]', categories_path, text: 'カテゴリ一覧', count: 0
    assert_select 'a[href=?]', help_path, text: 'ヘルプ'
    assert_select 'a[href=?]', logout_path, text: 'ログアウト'    
  end
end
