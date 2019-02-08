class ReportsController < ApplicationController
  before_action :require_logged_in
  include ReportsHelper

  def categories
    @categories = Category.all.order(:id)
    target_terms = get_target_terms
    @report_target_terms = target_terms.select do |term|
      Book
        .get_all_on_target_month(term[:year], term[:month])
        .payments
        .without_transfer
        .sum(:amount) > 0
    end
    @report = []
    @report_target_terms.each do |term|
      monthly_summary = get_monthly_summary(term)
      monthly_summary.each do |category_id, amount|
        @report << {
          year: term[:year],
          month: term[:month],
          category_id: category_id,
          sum: amount,
        }
      end
      @report << {
        year: term[:year],
        month: term[:month],
        total: monthly_summary.values.inject(:+)
      }
    end
    @debug = @report
  end

  private

  def get_target_terms
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

  def get_monthly_summary(term)
    Book
      .get_all_on_target_month(term[:year], term[:month])
      .payments
      .without_transfer
      .group(:category_id)
      .sum(:amount)
  end
end