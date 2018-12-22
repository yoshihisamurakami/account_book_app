require 'test_helper'

class BooksTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = users(:admin)
    @user = users(:murakami)
    @account = accounts(:yoshihisa_bank)
    @category = categories(:daily_goods)
  end

  test "未ログイン状態で/ページを開いたらリダイレクトされること" do
    get root_path
    assert_redirected_to login_url
  end

  test "カテゴリがなしでも入金してOK" do
    log_in_as(@user)
    assert_difference 'Book.count', 1 do
    post books_path, params: { book: {
      books_date:  "2018-11-25",
      user_id: @user.id,
      account_id: @account.id,
      deposit: true,
      transfer: false,
      category_id: nil,
      summary: '入金',
      amount: 10000,
      common: false,
      business: false,
      special: false,
    } }
    end
  end
end
