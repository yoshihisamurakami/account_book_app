class MonthlyReportModel
  def initialize(target_term, budget, lastday, day, cost_total)
    @_target_term = target_term
    @_budget  = budget
    @_lastday = lastday
    @_day     = day
    @_cost_of_living_without_fixed = @_budget.cost_of_living_without_fixed
    @_cost_total = cost_total
  end

  def date
    Date.new(@_target_term.year, @_target_term.month, @_day).strftime("%Y-%m-%d")
  end

  # a)目標ライン（累計）
  def budget
    ((@_cost_of_living_without_fixed / @_lastday.to_f) * @_day).to_i
  end

  # b) 生活費（実績）
  def cost
    living_categories = Category.where(is_tax: false, is_fixed: false).select(:id)
    Book.cost_of_living(@_target_term.year, @_target_term.month, @_day, living_categories)
  end

  # c) 生活費（累計）
  def cost_total
    @_cost_total + cost
  end

  # d) 差分a - c
  def diff
    budget - cost_total
  end
end