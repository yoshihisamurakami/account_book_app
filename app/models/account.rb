class Account < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :comment, length: { maximum: 50 }
  has_many :books
  
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
  
end
