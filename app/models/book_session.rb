class BookSession
  attr_reader :session

  def initialize(session)
    @session = session
  end

  def new_book_attributes
    attributes = {
      account_id: account_id,
      category_id: category_id
    }
    attributes = attributes.merge({books_date: books_date}) if books_date.present?
    attributes
  end

  def clear!
    session[:books_date] = nil
    session[:account_id] = nil
    session[:category_id] = nil
  end

  private

  def books_date
    session[:books_date]
  end

  def account_id
    session[:account_id]
  end

  def category_id
    session[:category_id]
  end
end