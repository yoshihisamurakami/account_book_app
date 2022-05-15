class MonthlyReportsController < ApplicationController
  before_action :require_logged_in, only: [:index]
  
  def index
    @target_month = TargetMonth.new(session)
    @budget = Budget.get_by_target(@target_month)
    @monthly_reports = MonthlyReportListModel.new(@target_month)
    @years_report = YearsReportModel.new(@target_month)
  end
end
