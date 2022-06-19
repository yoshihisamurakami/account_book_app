module StaticPageActions
  extend ActiveSupport::Concern

  def set_books_updated_today
    @books_updated_today = current_user.books
      .updated_today
      .order(:books_date, :created_at)
      .paginate(page: params[:page])
  end

  def set_accounts
    @accounts = Account.all.order(:id).decorate
  end

end
