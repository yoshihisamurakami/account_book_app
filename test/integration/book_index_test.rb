require 'test_helper'

class BooksIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:murakami)
  end

  test "未ログイン状態で家計簿一覧ページを開いたらリダイレクトされること" do
    get books_path
    assert_redirected_to login_url
  end


  test "家計簿一覧ページが正常であること" do
    log_in_as(@user)
    get books_path
    assert_response :success
    assert_template 'books/index'

  end
end