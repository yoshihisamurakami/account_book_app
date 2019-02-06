require 'test_helper'

class BooksIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:murakami)
    @prev_month = Date.today.prev_month(1)
    @next_month = Date.today.next_month(1)
  end

  test "未ログイン状態で家計簿一覧ページを開いたらリダイレクトされること" do
    get books_path
    assert_redirected_to login_url
  end

  test "家計簿一覧ページが正常であること、前の月リンクが正常動作すること" do
    log_in_as(@user)
    get books_path
    assert_response :success
    assert_template 'books/index'
    get prev_month_path
    assert_equal session[:target_term_year], @prev_month.year
    assert_equal session[:target_term_month], @prev_month.month
  end

  test "次の月リンクが正常動作すること" do
    log_in_as(@user)
    get books_path
    assert_response :success
    assert_template 'books/index'
    get next_month_path
    assert_equal session[:target_term_year], @next_month.year
    assert_equal session[:target_term_month], @next_month.month
  end

end