class MonthlyReportsController < ApplicationController
  before_action :require_logged_in, only: [:index]

  def index
    @target_term = TargetTermModel.new(session)
    @monthly_reports = MonthlyReportListModel.new(@target_term)
  end

end