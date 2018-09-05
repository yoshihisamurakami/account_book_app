require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:murakami)
  end
  
  #test "ログインしないで / にアクセスした場合、ログイン画面へリダイレクトされること" do
  #  get root_path
  #  assert_redirected_to login_url
  #end

  test "ログイン後、/ にアクセスできること" do
    log_in_as(@user)
    get root_path
    assert_response :success
    assert_select "title", "家計簿の入力 - 家計簿App"
  end
  
  test "/help ページにアクセスできること" do
    get help_path
    assert_response :success
    assert_select "title", "ヘルプ - 家計簿App"
  end

end
