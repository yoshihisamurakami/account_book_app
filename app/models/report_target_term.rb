class ReportTargetTerm
  class << self
    def target_terms
      # 通常
      # one_year_terms.select do |term|
      #   Book.pure_payments_total(term[:year], term[:month]).positive?
      # end

      # 2022年確定申告
      year_2022.select do |term|
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

    def year_2022
      [
        {year: 2022, month: 1},
        {year: 2022, month: 2},
        {year: 2022, month: 3},
        {year: 2022, month: 4},
        {year: 2022, month: 5},
        {year: 2022, month: 6},
        {year: 2022, month: 7},
        {year: 2022, month: 8},
        {year: 2022, month: 9},
        {year: 2022, month: 10},
        {year: 2022, month: 11},
        {year: 2022, month: 12},
      ]
    end
  end
end