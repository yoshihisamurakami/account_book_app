class BooksController < ApplicationController
  before_action :set_books_updated_today, only: [:edit, :update, :destroy]
  before_action :set_accounts, only: [:create, :edit, :update, :destroy]
  before_action :require_logged_in, only: [:index]
  include StaticPageActions

  def index
    @target_month = TargetMonth.new(session)
    @books = Book
      .eager_load(:user, :account, :category)
      .target_month(@target_month.year, @target_month.month)
      .page(params[:page])
      .order(:books_date, :created_at)
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
    # if params[:commit] == 'コピー'
    #   copy
    #   return
    # else
      if @book.update(book_params)
        flash[:success] = "更新されました。"
        redirect_to root_url
      else
        render 'static_pages/home'
      end
    # end
  end

  # update時 （確定申告向けコピー操作時に使う）
  # def copy
  #   @book = Book.new(book_params)
  #   params_to_session
  #   if @book.save
  #     flash[:success] = "コピーされました！！"
  #     redirect_to root_url
  #   else
  #     render 'static_pages/home'
  #   end
  # end

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
    target_term = TargetMonth.new(session)
    books_tsv = BooksTsv.new(target_term.year)
    tsv_data = books_tsv.get
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
