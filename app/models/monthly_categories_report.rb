# カテゴリ別まとめページ
class MonthlyCategoriesReport
  attr_reader :categories, :report_target_terms, :report

  def initialize; end

  def categories
    @categories ||= Category.all.order(:id)
  end

  def report_target_terms
    @report_target_terms ||= ReportTargetTerm.target_terms
  end

  def report
    ret = []
    report_target_terms.each do |term|
      monthly_summary = get_monthly_summary(term)
      monthly_summary.each do |category_id, amount|
        ret << {
          year: term[:year],
          month: term[:month],
          category_id: category_id,
          sum: amount,
        }
      end
      ret << {
        year: term[:year],
        month: term[:month],
        total: monthly_summary.values.inject(:+)
      }
    end
    ret
  end

  private

  def get_monthly_summary(term)
    Book
      .target_month(term[:year], term[:month])
      .payments
      .without_transfer
      .group(:category_id)
      .sum(:amount)
  end
end
