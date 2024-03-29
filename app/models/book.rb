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

  delegate :name, to: :user, prefix: true
  delegate :name, to: :account, prefix: true
  delegate :name, to: :category, prefix: true, allow_nil: true

  scope :payments, -> { where(deposit: false) }
  scope :deposits, -> { where(deposit: true) }
  scope :without_transfer, -> { where(transfer: false) }
  scope :privates, -> { where(common: false) }
  scope :commons, -> { where(common: true) }
  scope :specials, -> { where(special: true) }

  scope :target_year, ->(year) {
    where("books_date >= ?", Date.new(year, 1, 1))
    .where("books_date <= ?", Date.new(year, 12, 31))
  }

  scope :target_month, ->(year, month) {
    where("books_date >= ?", Date.new(year, month, 1))
    .where("books_date <= ?", Date.new(year, month, -1))
  }

  scope :target_month_and_page, ->(target_month:, page:) {
    target_month(target_month.year, target_month.month)
    .page(page)
    .order(:books_date, :created_at)
  }

  scope :updated_today, -> { where('updated_at > ?', Time.now - 1.days) }

  def set_default
    self.books_date ||= Time.zone.now
    self.deposit ||= false
  end

  def payment
    !deposit
  end

  # 当該オブジェクトの更新後の残高
  def updated_balance
    return 0 if account.nil?
    balance = account.balance
    if persisted? and !amount_was.nil?
      balance = adjust_before_update(balance)
    end
    unless amount.nil?
      balance = update_amount_by_this_record(balance)
    end
    balance
  end

  # 残高がマイナスになったら false
  def valid_balance?
    if updated_balance < 0
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

  def self.pure_payments_total(year, month)
    self
      .target_month(year, month)
      .payments
      .without_transfer
      .sum(:amount)
  end

  def self.pure_deposit_total(year, month)
    self
      .target_month(year, month)
      .deposits
      .without_transfer
      .sum(:amount)
  end

  def self.categories_total(year, month, categories)
    self
      .target_month(year, month)
      .where(category_id: categories, special: false)
      .sum(:amount)
  end

  def self.special_total(year, month)
    self
      .target_month(year, month)
      .specials
      .sum(:amount)
  end

  def self.cost_of_living(year,month,day, living_categories)
    date = Date.new(year, month, day)
    self
      .where(
        "books_date = ?", date)
      .where(
        special: false,
        category_id: living_categories
      ).payments
      .without_transfer
      .sum(:amount)
  end

  private

  def adjust_before_update(balance)
    if deposit?
      balance - amount_was
    else
      balance + amount_was
    end
  end

  def update_amount_by_this_record(balance)
    if deposit?
      balance + amount
    else
      balance - amount
    end
  end
end
