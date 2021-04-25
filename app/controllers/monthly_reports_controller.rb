class MonthlyReportsController < ApplicationController
  before_action :require_logged_in, only: [:index]
  
  def index
    @target_term = TargetTermModel.new(session)
    @budget = Budget.get_by_target(@target_term)
    @monthly_reports = MonthlyReportListModel.new(@target_term)
    @years_report = YearsReportModel.new(@target_term)
  end
end
