class YearsReportModel

  def initialize(target_term)
    @target_month = target_term
  end

  def reguler_income
    Budget.where(target_year: @target_month.year).sum(:regular_income)
  end

  def extra_income
    Budget.where(target_year: @target_month.year).sum(:extra_income)
  end

  def income_total
    reguler_income + extra_income
  end

  # 税金支払い合計（実績値）
  def tax_total_actual
    Book.joins(:category)
      .where("books_date >= ?", years_first_day)
      .where("books_date <= ?", years_last_day)
      .where(deposit: false, transfer: false, categories: {is_tax: true})
      .sum(:amount)
  end

  # 税金積立合計
  def tax_funding
    Budget.where(target_year: @target_month.year).sum(:tax_funding)
  end

  # 特別経費支出の合計（実績値）
  def special_actual
    Book
      .where("books_date >= ?", years_first_day)
      .where("books_date <= ?", years_last_day)
      .where(deposit: false, transfer: false, special: true)
      .sum(:amount)
  end

  # 特別経費積立の合計
  def special_funding
    Budget.where(target_year: @target_month.year).sum(:special_funding)
  end

  # 年間支出合計（実績値）
  def payment_total
    Book
      .where("books_date >= ?", years_first_day)
      .where("books_date <= ?", years_last_day)
      .where(deposit: false, transfer: false)
      .sum(:amount)
  end

  # 収入合計 - 年間支出合計
  def diff
    self.income_total - self.payment_total
  end

  private

  def years_first_day
    Date.new(@target_month.year, 1, 1)
  end

  def years_last_day
    Date.new(@target_month.year, 12, 31)
  end
end
