class Book < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :category, required: false

  validate :valid_balance?

  # 保存されているレコードの残高
  def balance
    deposit_total - payment_total
  end

  def deposit_total
    account.deposit_total + deposit_amount
  end

  def deposit_amount
    return 0 if !deposit
    persisted? ? updated_amount : amount
  end
  
  def payment_total
    account.payment_total + payment_amount
  end

  def payment_amount
    return 0 if deposit
    persisted? ? updated_amount : amount
  end
  
  # レコードが更新された場合の、更新前後の差額
  def updated_amount
    amount - amount_was
  end
  
  # 残高がマイナスになったら false
  def valid_balance?
    if balance < 0
      errors.add(:amount, "残高がマイナスになるようです")
    end
  end
end
