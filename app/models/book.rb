class Book < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :category, required: false

  validate :valid_balance?
  before_destroy :check_balance_before_destroy
  
  def payment
    !deposit
  end
  
  # 当該オブジェクトの更新後の残高
  def balance
    balance = account.balance
    if persisted? and !amount_was.nil?
      if deposit?
        balance -= amount_was
      else
        balance += amount_was
      end
    end
    if deposit?
      balance += amount
    else
      balance -= amount
    end
    balance
  end
  
  # 残高がマイナスになったら false
  def valid_balance?
    if balance < 0
      errors.add(:amount, "残高がマイナスになるようです")
      return false
    end
    true
  end
  
  def check_balance_before_destroy
    self.amount = 0
    throw(:abort) if !valid_balance?
  end
end
