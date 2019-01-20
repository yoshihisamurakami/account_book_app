class StaticPagesController < ApplicationController
  before_action :require_logged_in, only: [:home]

  def home
    @book = current_user.books.build
    @book_view = BookViewModel.new(current_user, params)
  end

  def help
  end
end
