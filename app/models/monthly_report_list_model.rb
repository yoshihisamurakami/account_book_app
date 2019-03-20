class MonthlyReportListModel
  attr_reader :message, :reports

  def initialize(target_term)
    @message = ''
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
    @reports = []
    cost_total = 0
    (1..lastday).each do |day|
      report = MonthlyReportModel.new(@target_term, @budget, lastday, day, cost_total)
      @reports.push report
      cost_total = report.cost_total
    end
  end
end