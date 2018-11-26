class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = "保存されました。"
      redirect_to root_url
    else
      #render partial: "js_error", object: @book
      render 'static_pages/home'
    end
    # render 'static_pages/home'
  end

  private

  def book_params
    # params.require(:book).permit(
    #   :books_date, :user_id,
    #   :account_id, :deposit, :transfer,
    #   :category_id, :summary,
    #   :amount, :common, :business, :special)
    params.require(:book).permit(
      :books_date, :user_id,
      :account_id, :deposit, :transfer,
      :category_id, :summary,
      :amount,
      :common, :business, :special,
    )
  end

end
