class ReportTargetTerm
  class << self
    def target_terms
      one_year_terms.select do |term|
        Book.pure_payments_total(term[:year], term[:month]).positive?
      end
    end

    private

    def one_year_terms
      terms = []
      target_date = Date.today.prev_year(1)
      today = Date.today
      loop do
        target_date = target_date.next_month(1)
        terms << {
          year: target_date.year,
          month: target_date.month
        }
        break if target_date.year == today.year and target_date.month == today.month
      end
      terms
    end
  end
end