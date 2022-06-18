class MonthlyReportListModel
  attr_reader :message, :reports

  def initialize(target_term)
    @message = ''
    @target_month = target_term
    set_budget
    unless @budget
      @message = '対象月の予算が設定されていません。'
    else
      set_monthly_reports
    end
  end

  private

  def set_budget
    @budget = Budget.get_by_target(@target_month)
  end

  def set_monthly_reports
    lastday = @target_month.lastday_of_month
    @reports = []
    (1..lastday).each do |day|
      report = MonthlyReportModel.new(@target_month, @budget, lastday, day)
      @reports.push report
      report.set_cost_total(cost_total)
    end
  end

  def cost_total
    @reports.inject(0) { |sum, report| sum + report.cost }
  end
end