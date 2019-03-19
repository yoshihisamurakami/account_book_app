class MonthlyReportModel
  def initialize(target_term, budget, lastday, day, cost_total)
    @target_term = target_term
    @budget  = budget
    @lastday = lastday
    @day     = day
    @cost_of_living_without_fixed = @budget.cost_of_living_without_fixed

    @_cost_total = cost_total
  end

  def budget
    ((@cost_of_living_without_fixed / @lastday.to_f) * @day).to_i
  end

  def cost_of_living
    Book.cost_of_living
  end

  def cost_total
    @_cost_total + cost_of_living
  end

  def diff
    budget - cost_total
  end
end