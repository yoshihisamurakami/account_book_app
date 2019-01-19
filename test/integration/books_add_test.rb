require 'test_helper'

class BooksTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = users(:admin)
    @user = users(:murakami)
    @account = accounts(:yoshihisa_bank)
    @category = categories(:daily_goods)
    @book_pay = books(:buy_daily_goods)
  end

  test "未ログイン状態で/ページを開いたらリダイレクトされること" do
    get root_path
    assert_redirected_to login_url
  end

  test "10000円入金したあと、1000円出金する" do
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
    assert_equal @account.balance, 10000
    assert_difference 'Book.count', 1 do
    post books_path, params: { book: {
      books_date:  "2018-11-26",
      user_id: @user.id,
      account_id: @account.id,
      deposit: false,
      transfer: false,
      category_id: @category.id,
      summary: '出金',
      amount: 1000,
      common: false,
      business: false,
      special: false,
    } }
    end
    assert_equal @account.balance, 9000
  end

  test "update成功" do
    log_in_as(@user)
    get edit_book_path(@book_pay.id)
    assert_template 'static_pages/home'
    # post edit_book_path(@book_pay.id), params: { book: {
    #   books_date: "2018-10-28",
    #   user: users(:murakami),
    #   account: accounts(:yoshihisa_wallet),
    #   deposit: false,
    #   transfer: false,
    #   category: categories(:daily_goods),
    #   summary: 'ウェットティッシュ',
    #   amount: 1000,
    #   common: true,
    #   business: false,
    #   special: false ,
    #   }}
  end

end
