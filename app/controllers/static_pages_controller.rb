class StaticPagesController < ApplicationController
  before_action :require_logged_in, only: [:home]
  
  def home
    @book = current_user.books.build
    @book.books_date = '2018/11/03'
  end

  def help
  end
end
