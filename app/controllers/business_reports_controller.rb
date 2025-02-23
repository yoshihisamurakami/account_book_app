class BusinessReportsController < ApplicationController
  # 確定申告向け、年間の事業経費カテゴリ別まとめ
  def categories
    report = MonthlyBusinessCategoriesReport.new(session)
    @categories = report.categories
    @report_target_terms = report.report_target_terms
    @report = report.report
  end
end
