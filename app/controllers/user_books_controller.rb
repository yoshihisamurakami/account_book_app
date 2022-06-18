class UserBooksController < ApplicationController
  before_action :require_logged_in

  # /user/:id/books
  def index
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:danger] = '指定したユーザーがみつかりません'
      redirect_to root_url
    end
    @target_month = TargetMonth.new(session)
    @user_books_summary = UserBooksSummary.new(@user, @target_month)
    @books = @user.books_list(target_month: @target_month, page: params[:page])
  end
end
