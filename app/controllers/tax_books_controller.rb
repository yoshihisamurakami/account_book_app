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
    book.update!(category_id: params[:val])
    render json: { status: 'ok' }
  end

  # 確定申告用 適用update
  def update_summary
    book.update!(summary: params[:val])
    render json: { status: 'ok' }
  end

  # 確定申告用 適用update
  def update_amount
    book.update!(amount: params[:val])
    render json: { status: 'ok' }
  end

  private

  def book
    Book.find(params[:tax_book_id])
  end
end
