class ReportsController < ApplicationController
  before_action :require_logged_in
  include ReportsHelper

  def categories
    @categories = Category.all.order(:id)
    target_terms = get_target_terms
    @report_target_terms = target_terms.select do |term|
      Book.pure_payments_total(term[:year], term[:month]) > 0
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
  end

  def deposit_payment
    target_terms = get_target_terms
    @report_target_terms = target_terms.select do |term|
      Book.pure_payments_total(term[:year], term[:month]) > 0
    end
    tax_categories = Category.tax
    fixed_categories = Category.where(is_fixed: true).select(:id)
    variable_categories = Category.living

    @report = []
    @report_target_terms.each do |term|
      pure_deposit = Book.pure_deposit_total(term[:year], term[:month])
      tax = Book.categories_total(term[:year], term[:month], tax_categories)
      special = Book.special_total(term[:year], term[:month])
      fixed = Book.categories_total(term[:year], term[:month], fixed_categories)
      variable = Book.categories_total(term[:year], term[:month], variable_categories)
      @report << {
        year: term[:year],
        month: term[:month],
        deposit: pure_deposit,
        tax: tax,
        special: special,
        fixed: fixed,
        variable: variable,
        living: fixed + variable,
        diff: pure_deposit - (tax + special + fixed + variable)
      }
    end
  end

  def deposit
    @target_term = TargetTermModel.new(session)
    @books = report_base_books.deposits.without_transfer
  end

  def tax
    @target_term = TargetTermModel.new(session)
    @books = report_base_books.where(category_id: Category.tax)
  end
  
  def special
    @target_term = TargetTermModel.new(session)
    @books = report_base_books.where(special: true)
  end

  def business
    @target_term = TargetTermModel.new(session)
    @books = report_base_books.where(business: true)
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
      .target_month(term[:year], term[:month])
      .payments
      .without_transfer
      .group(:category_id)
      .sum(:amount)
  end

  def report_base_books
    Book
      .target_month(@target_term.year, @target_term.month)
      .page(params[:page])
      .order(:books_date, :created_at)
  end

end