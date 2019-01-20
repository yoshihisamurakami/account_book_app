require 'test_helper'

class BooksTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = users(:admin)
    @user = users(:murakami)
    @account = accounts(:yoshihisa_bank)
    @account_wallet = accounts(:yoshihisa_wallet)
    @category = categories(:daily_goods)
    @book_deposit = books(:first_deposit)
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

  test "20000円入金された状態で、300円出金分のレコードを30000円出金に変更し、updateに失敗すること" do
    deposit_amount = @book_deposit.amount
    payment_amount = @book_pay.amount
    assert_equal deposit_amount - payment_amount, @account_wallet.balance
    log_in_as(@user)
    get edit_book_path(@book_pay.id)
    assert_template 'static_pages/home'
    @book_pay.amount = 30000
    patch book_path(@book_pay.id), params: parameter_to_post(@book_pay)
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger', text: /エラーがみつかりました/
    assert_select 'li', /残高がマイナスになるようです/
    assert_not_equal deposit_amount - @book_pay.amount, @account_wallet.balance
  end

  test "20000円入金された状態で、300円出金分のレコードを1000円出金に変更し、updateに成功すること" do
    deposit_amount = @book_deposit.amount
    payment_amount = @book_pay.amount
    assert_equal deposit_amount - payment_amount, @account_wallet.balance
    log_in_as(@user)
    get edit_book_path(@book_pay.id)
    assert_template 'static_pages/home'
    @book_pay.amount = 1000
    patch book_path(@book_pay.id), params: parameter_to_post(@book_pay)
    assert_not flash.empty?
    assert_redirected_to root_path
    follow_redirect!
    assert_select 'div.alert-success', text: /更新されました/
    assert_equal deposit_amount - @book_pay.amount, @account_wallet.balance
  end

  test "20000円入金 + 300円出金 のレコードがある状態から 20000円入金のレコードを削除できないこと" do
    log_in_as(@user)
    assert_no_difference 'Book.count' do
      delete book_path(@book_deposit)
    end
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger', text: /エラーがみつかりました/
    assert_select 'li', /残高がマイナスになるようです/
  end

  test "20000円入金 + 300円出金 のレコードがある状態から 300円出金のレコードは削除できること" do
    log_in_as(@user)
    assert_difference 'Book.count', -1 do
      delete book_path(@book_pay)
    end
    assert_not flash.empty?
    assert_redirected_to root_path
    follow_redirect!
    assert_select 'div.alert-success', text: /削除されました/
  end

end
