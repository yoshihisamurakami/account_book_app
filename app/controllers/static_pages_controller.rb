class StaticPagesController < ApplicationController
  before_action :require_logged_in, only: [:home]
  before_action :set_books_updated_today, only: [:home]
  before_action :set_accounts, only: [:home]

  include StaticPageActions

  def home
    @book = current_user.books.build
    set_from_session
  end

  def help
  end

  private

  def set_from_session
    @book.books_date = session[:books_date] if session[:books_date].present?
    @book.account_id ||= session[:account_id]
    @book.category_id ||= session[:category_id]

    # 1回使ったら破棄する
    session[:books_date] = nil
    session[:account_id] = nil
    session[:category_id] = nil
  end

end
