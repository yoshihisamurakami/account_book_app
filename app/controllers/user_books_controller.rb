class UserBooksController < ApplicationController
  before_action :require_logged_in

  # /user/:id/books
  def index
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:danger] = '指定したユーザーがみつかりません'
      redirect_to root_url
    end
    @target_term = TargetTermModel.new(session)
    @books = @user
      .books
      .target_month(@target_term.year, @target_term.month)
      .page(params[:page])
      .order(:books_date, :created_at)
    @user_books_view = UserBooksViewModel.new(@user, @target_term)
  end
end
