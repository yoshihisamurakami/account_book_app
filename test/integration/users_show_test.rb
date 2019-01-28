require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:murakami)
  end

  test "未ログイン状態でユーザー別の家計簿一覧ページを開いたらリダイレクトされること" do
    get user_path(@user)
    assert_redirected_to login_url
  end

  test "ログイン後は閲覧できること" do
    log_in_as(@user)
    get user_path(@user)
    assert_response :success
    assert_template 'users/show'
  end

end