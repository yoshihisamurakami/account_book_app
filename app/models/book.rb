class Book < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :category, optional: true

  validates :books_date, presence: true
  validates :summary,    presence: true
  validates :amount,     numericality: { only_integer: true }
  validate  :valid_balance?
  validate  :category_valid_on_payment
  validate  :cateogry_valid_on_deposit
  before_destroy :check_balance_before_destroy
  after_initialize :set_default, if: :new_record?

  def set_default
    self.books_date = Time.zone.now
    self.deposit ||= false
  end

  def payment
    !deposit
  end

  # 当該オブジェクトの更新後の残高
  def balance
    return 0 if account.nil?
    balance = account.balance
    if persisted? and !amount_was.nil?
      if deposit?
        balance -= amount_was
      else
        balance += amount_was
      end
    end
    if !amount.nil?
      if deposit?
        balance += amount
      else
        balance -= amount
      end
    end
    balance
  end

  # 残高がマイナスになったら false
  def valid_balance?
    if balance < 0
      errors.add(:amount, " 残高がマイナスになるようです")
      return false
    end
    true
  end

  def category_valid_on_payment
    if payment and !transfer
      if category.nil?
        errors.add(:category, "出金の場合は必ずカテゴリを選んで下さい。")
      end
    end
  end

  def cateogry_valid_on_deposit
    if deposit
      unless category.nil?
        errors.add(:category, "入金の場合はカテゴリを選ばないで下さい。")
      end
    end
  end

  def check_balance_before_destroy
    self.amount = 0
    throw(:abort) if !valid_balance?
  end

  def self.get_on_target_month(year, month, page)
    start = Date.new(year, month, 1)
    last  = Date.new(year, month, -1)
    self
      .where("books_date >= ?", start)
      .where("books_date <= ?", last)
      .order(:books_date, :created_at)
      .paginate(page: page)
  end
end
