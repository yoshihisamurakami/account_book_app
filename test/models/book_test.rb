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
    assert_equal @book_depo.deposit_total, 20000
    assert_equal @book_depo.payment_total, 0
    assert @book_depo.valid?
  end

  test "（口座残高がない状態からの）出金はエラーになること" do
    assert_equal @book_pay.deposit_total, 0
    assert_equal @book_pay.payment_total, 5000
    assert_not @book_pay.valid?
  end

  test "入金したあとの出金は正常になること" do
    @book_depo.save
    assert @book_pay.valid?
  end
  
  test "入金金額以上の出金はエラーになること" do
    @book_depo.save
    @book_pay.amount = 20010
    assert_not @book_pay.valid?
  end
  
  test "入金・出金レコード保存後、出金側の金額を残高がマイナスになるように大きく更新できないこと" do
    @book_depo.save
    @book_pay.save
    @book_pay.amount = 30000
    assert_equal @book_pay.deposit_total, 20000
    assert_equal @book_pay.payment_total, 30000
    assert_not @book_pay.valid?
  end

  test "入金・出金レコード保存後、入金側の金額を残高がマイナスになるように小さく変更できないこと" do
    @book_depo.save
    @book_pay.save
    @book_depo.amount = 4000
    assert_equal @book_depo.deposit_total, 4000
    assert_equal @book_depo.payment_total, 5000
    assert_not @book_depo.valid?
  end
  
  test "入金したレコードは、残高がマイナスになる場合は削除できないこと" do
  end
  
end
