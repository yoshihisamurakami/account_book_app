require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:admin)
    @user = users(:murakami)
    @other_user = users(:tanaka)
  end

  test "管理者ユーザーで編集できること" do
    log_in_as(@admin_user)
    get edit_user_path(@user)
    assert_response :success
  end

  test "自分のユーザー情報は編集できること" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_response :success
  end
  
  test "別のユーザー情報は編集できないこと" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_redirected_to root_url
  end
  
  test "ユーザー編集失敗" do
    log_in_as(@user)
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
    log_in_as(@user)
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
