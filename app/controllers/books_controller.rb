class BooksController < ApplicationController
  before_action :set_books_updated_today, only: [:edit, :update, :destroy]
  before_action :set_accounts, only: [:create, :edit, :update, :destroy]
  before_action :require_logged_in, only: [:index]
  include StaticPageActions

  def index
    @target_term = TargetTermModel.new(session)
    @books = Book.get_on_target_month(@target_term.year, @target_term.month, params[:page])
  end

  def create
    @book = Book.new(book_params)
    params_to_session
    if @book.save
      flash[:success] = "保存されました。"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def edit
    @book = Book.find(params[:id])
    render 'static_pages/home'
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      flash[:success] = "更新されました。"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:success] = "削除されました。"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def tsv
    target_term = TargetTermModel.new(session)
    books = Book.get_on_target_year(target_term.year)
    tsv_data = CSV.generate(:col_sep => "\t") do |tsv|
      columns = %W(id books_date user_id account_id deposit transfer category_id summary amount
                   common business special created_at updated_at)
      tsv << columns
      books.each do |book|
        tsv << [
          book.id,
          book.books_date,
          book.user_id,
          book.account_id,
          book.deposit,
          book.transfer,
          book.category_id,
          book.summary,
          book.amount,
          book.common,
          book.business,
          book.special,
          book.created_at,
          book.updated_at
        ]
      end
    end
    send_data tsv_data, type: 'text/tsv; charset=utf-8', filename: "tmpfile.tsv"
  end

  private

  def book_params
    params.require(:book).permit(
      :books_date, :user_id,
      :account_id, :deposit, :transfer,
      :category_id, :summary,
      :amount,
      :common, :business, :special,
    )
  end

  def params_to_session
    session[:books_date] = @book.books_date
    session[:account_id] = @book.account_id 
    session[:category_id] = @book.category_id
  end
end
