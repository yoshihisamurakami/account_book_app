class BookViewModel
  include SessionsHelper
  include BooksHelper
  attr_accessor :updated_today, :accounts

  def initialize(user, params)
    @updated_today = books_updated_today(user, params)
    @accounts = Account.all
  end
end
