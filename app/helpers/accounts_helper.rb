module AccountsHelper

  def get_balance(book)
    @balance ||= @carryover
    if book.deposit?
      @balance += book.amount
    else
      @balance -= book.amount
    end
  end
end