class Account < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :comment, length: { maximum: 50 }
  has_many :books

  def balance
    deposit_total - payment_total
  end

  def deposit_total
    books
      .where(deposit: true)
      .sum(:amount)
  end

  def payment_total
    books
      .where(deposit: false)
      .sum(:amount)
  end

  def balance_before_target_date(target_date)
    deposit_total = books
      .deposits
      .where("books_date < ?", target_date)
      .sum(:amount)
    payment_total = books
      .payments
      .where("books_date < ?", target_date)
      .sum(:amount)
      deposit_total - payment_total
  end
end
