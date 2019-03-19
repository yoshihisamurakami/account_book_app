class MonthlyReportListModel

  def initialize(target_term)
    @target_term = target_term
    set_budget
    unless @budget
      @message = '対象月の予算が設定されていません。'
    else
      set_monthly_reports
    end
  end

  private

  def set_budget
    @budget = Budget.get_by_target(@target_term)
  end

  def set_monthly_reports
    lastday = @target_term.lastday_of_month
    @cost_of_living_without_fixed = @budget.cost_of_living_without_fixed
    @livings = {}
    @cost_total = 0
    (1..lastday).each do |day|
      @report = MonthlyReportModel.new(@target_term, @budget, lastday, day, @cost_total)
      # @livings[day] = {
      #  budget: @report.budget,
      #  cost: @report.cost_of_living,
      #  cost_total: @report.cost_total,
      #  diff: @report.diff,
      #}
      @livings[day] = @report
      @cost_total = @report.cost_total
    end
  end

# a) 目標ライン（累計）
# b) 実績
# c) 実績（累計）
# d) 差分 a-c

end