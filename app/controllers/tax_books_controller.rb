class TaxBooksController < ApplicationController
  before_action :require_logged_in, only: [:index]
  include StaticPageActions

  def index
    @target_term = TargetTermModel.new(session)
    @books = Book
      .eager_load(:user, :account, :category)
      .target_month(@target_term.year, @target_term.month)
      .order(:books_date, :created_at)
    @category_select = Category.all.order(:id).map{|o| [o.id.to_s + ':' + o.name, o.id]}.unshift(["（選択）",nil])
  end

  # 確定申告用 事業経費update
  def update_business
    book.update!(business: params[:checked])
    render json: { status: 'ok' }
  end

  # 確定申告用 カテゴリupdate
  def update_category
    is_checked_business = false
    if business_category?(params[:val])
      book.update!(category_id: params[:val], business: true)
      is_checked_business = true
    else
      book.update!(category_id: params[:val])
    end
    render json: { status: 'ok', is_checked_business: is_checked_business }
  end

  # 確定申告用 適用update
  def update_summary
    book.update!(summary: params[:val])
    render json: { status: 'ok' }
  end

  # 確定申告用 適用update
  def update_amount
    amount = params[:val].gsub(/,/, '')
    book.update!(amount: amount)
    render json: { status: 'ok', formatted_amount: formatted_amount(amount) }
  end

  private

  def book
    Book.find(params[:tax_book_id])
  end

  def business_category?(category_id)
    [21, 23, 27, 28, 29].include?(category_id.to_i)
  end

  def formatted_amount(amount)
    amount.to_i.to_s(:delimited)
  end
end
