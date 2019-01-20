class BookViewModel
  include SessionsHelper
  include BooksHelper
  attr_accessor :updated_today, :accounts

  def initialize(user)
    @updated_today = books_updated_today(user)
    @accounts = Account.all
  end
end
