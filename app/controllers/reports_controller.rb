class ReportsController < ApplicationController
  before_action :require_logged_in
  include ReportsHelper

  def categories
    report = MonthlyCategoriesReport.new
    @categories = report.categories
    @report_target_terms = report.report_target_terms
    @report = report.report
  end

  def deposit_payment
    @report_target_terms = ReportTargetTerm.target_terms
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
    @target_month = TargetMonth.new(session)
    @books = report_base_books.deposits.without_transfer
  end

  def tax
    @target_month = TargetMonth.new(session)
    @books = report_base_books.where(category_id: Category.tax)
  end
  
  def special
    @target_month = TargetMonth.new(session)
    @books = report_base_books.where(special: true)
  end

  def business
    @target_month = TargetMonth.new(session)
    @books = report_base_books.where(business: true)
  end

  private

  def report_base_books
    Book
      .target_month(@target_month.year, @target_month.month)
      .page(params[:page])
      .order(:books_date, :created_at)
  end

end