module StaticPageActions
  extend ActiveSupport::Concern
  include BooksHelper
  
  def set_books_updated_today
    @books_updated_today = books_updated_today(current_user, params)
  end

  def set_accounts
    @accounts = Account.all.order(:id).decorate
  end

end
