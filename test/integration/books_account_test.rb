require 'test_helper'

class BooksAccountTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:murakami)
    @account = accounts(:yoshihisa_wallet)
  end

  test "未ログイン状態で口座別一覧ページを開いたらリダイレクトされること" do
    get books_account_path(@account)
    assert_redirected_to login_url
  end

  test "ログイン後は口座別一覧ページを閲覧できること" do
    log_in_as(@user)
    get books_account_path(@account)
    assert_response :success
    assert_template 'accounts/books'
  end
end