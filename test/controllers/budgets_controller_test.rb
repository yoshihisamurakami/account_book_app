require 'test_helper'

class BudgetsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:murakami)
  end

  test "未ログインのときは一覧画面にアクセスできないこと" do
    get budgets_path
    assert_redirected_to login_url
  end

  test "ログイン後は一覧画面にアクセスできること" do
    log_in_as(@user)
    get budgets_path
    assert_response :success
  end

end