require 'test_helper'

class BookTest < ActiveSupport::TestCase
  def setup
    @user = users(:murakami)
    @account = accounts(:yoshihisa_bank)
    @book_depo = Book.new(
      books_date: '2018-10-28',
      user: @user,
      account: @account,
      deposit: true,
      transfer: false,
      category: nil,
      summary: '銀行へ入金',
      amount: 20000,
      common: false,
      business: false,
      special: false,
    )
    @book_pay = Book.new(
      books_date: '2018-10-28',
      user: @user,
      account: @account,
      deposit: false,
      transfer: false,
      category: categories(:inhabitant_tax),
      summary: '住民税',
      amount: 5000,
      common: true,
      business: true,
      special: false,
    )
  end

  test "入金は正常であること" do
    assert @book_depo.valid?
  end

  test "（口座残高がない状態からの）出金はエラーになること" do
    assert_equal @book_pay.deposit_total, 0
    assert_equal @book_pay.payment_total, 0
    assert_equal @book_pay.payment, 5000
    assert_not @book_pay.valid?
  end

  test "入金直後の残高が正しいこと" do
    @book_depo.save
    assert_equal @book_depo.deposit_total, 20000
    assert_equal @book_depo.payment_total, 0
  end

  test "入金したあとの出金は正常になること" do
    #@book_depo.save
    #assert_equal @book_depo.deposit_total, 20000
    #assert @book_buy.valid?
  end

end
