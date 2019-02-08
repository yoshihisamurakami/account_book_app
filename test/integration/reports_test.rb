require 'test_helper'

class ReportsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:murakami)
  end

  test "未ログイン状態で「カテゴリ別まとめ」ページを開いたらリダイレクトされること" do
    get report_categories_path
    assert_redirected_to login_url
  end

  test "ログイン後は「カテゴリ別まとめ」ページを閲覧できること" do
    log_in_as(@user)
    get report_categories_path
    assert_response :success
    assert_template 'reports/categories'
  end
end