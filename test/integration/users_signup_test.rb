require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "無効な情報でユーザー登録したときの動作" do
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
    assert_select 'li', /名前を入力してください/
    assert_select 'li', /Emailは不正な値です/
    assert_select 'li', /パスワード（確認用）とパスワードの入力が一致しません/
    assert_select 'li', /パスワードは6文字以上で入力してください/
  end
  
  test "正常な情報を送ったときのユーザー登録" do
    get new_user_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/index'
    assert_not flash.empty?
  end
end
