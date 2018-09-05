require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:murakami)
  end

  test "ユーザー編集失敗" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'users/edit'
    assert_select 'div#error_explanation', text: /エラーがみつかりました/
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end
  
  test "ユーザー編集成功" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to users_path
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end  
end
