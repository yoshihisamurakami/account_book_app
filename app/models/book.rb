class Book < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :category, required: false

  validate :valid_balance?

  # 残高
  def balance
    deposit_total - payment_total - payment
  end

  def deposit_total
    account_books
      .where(deposit: true)
      .sum(:amount)
  end

  def payment_total
    account_books
      .where(deposit: false)
      .sum(:amount)
  end

  def payment
    if !deposit
      amount
    else
      0
    end
  end

  def account_books
    Book.where(account: account_id)
  end

  # 残高がマイナスになったら false
  def valid_balance?
    if (!deposit)
      if (balance < 0)
        errors.add(:amount, "残高がマイナスになるようです")
      end
    end
  end
end
