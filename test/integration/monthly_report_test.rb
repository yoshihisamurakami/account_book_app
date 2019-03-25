require 'test_helper'

class MonthlyReportTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:murakami)
    @budget = budgets(:january)
  end

  test "「生活費と残高」ページ ログインしていない場合はリダイレクトされること" do
    get monthly_report_path
    assert_redirected_to login_url
  end

  test "「生活費と残高」ページが正常であること" do
    log_in_as(@user)
    get monthly_report_path
    assert_template 'monthly_reports/index'
  end

end
