class MonthlyBusinessCategoriesReport
  attr_reader :session

  def initialize(session)
    @session = session
  end

  def categories
    @categories ||= Category.all.order(:id)
  end

  def report_target_terms
    @report_target_terms ||= fetch_report_target_terms
  end

  def report
    ret = []
    report_target_terms.each do |term|
      monthly_summary = get_monthly_summary(term)
      monthly_summary.each do |category_id, amount|
        ret << {
          year: term[:year],
          month: term[:month],
          category_id:,
          sum: amount
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

  def fetch_report_target_terms
    year = session[:target_term_year] || Date.today.year
    (1..12).map { |month| { year:, month: } }
  end

  def get_monthly_summary(term)
    Book
      .target_month(term[:year], term[:month])
      .payments
      .business
      .without_transfer
      .group(:category_id)
      .sum(:amount)
  end
end