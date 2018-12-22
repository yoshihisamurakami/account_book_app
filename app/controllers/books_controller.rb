class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
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

end
