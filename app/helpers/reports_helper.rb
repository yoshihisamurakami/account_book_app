module ReportsHelper
  def get_report(report: @report, category_id:, term:)
    target = report.select do |report|
      report[:category_id] == category_id and
      report[:year] == term[:year] and
      report[:month] == term[:month]
    end
    if target.empty?
      0
    else
      target.first[:sum]
    end
  end

  def get_report_total(report: @report, term:)
    target = report.select do |report|
      report[:year] == term[:year] and
      report[:month] == term[:month] and
      !report[:total].nil?
    end
    target.first[:total]
  end
end