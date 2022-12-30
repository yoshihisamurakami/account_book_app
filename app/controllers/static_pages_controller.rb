class StaticPagesController < ApplicationController
  before_action :require_logged_in, only: [:home]

  def home
    @book = current_user.books.build
    @book.attributes = book_session.new_book_attributes
    book_session.clear!
    @accounts = Account.balances.decorate
    @books_updated_today = books_updated_today
  end

  def help
  end

  private

  def book_session
    @book_session ||= BookSession.new(session)
  end

  def books_updated_today
    current_user.books
      .updated_today
      .order(:books_date, :created_at)
      .page(params[:page])
  end
end
