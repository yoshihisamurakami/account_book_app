class StaticPagesController < ApplicationController
  before_action :require_logged_in, only: [:home]

  def home
    @book = current_user.books.build
  end

  def help
  end
end
