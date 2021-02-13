# 指定口座に紐づく入出金

class AccountBooks

  def initialize(account_id, year, month)
    @account_id = account_id
    @year = year
    @month = month
    @account = Account.find(@account_id)
  end

  def account_name
    @account.name
  end

  def books
    @books ||= @account.books
      .target_month(@year, @month)
      .order(:books_date)
  end

  def carryover
    return 0 if books.empty?
    @account.balance_before_target_date(books.first.books_date)
  end

end