module BooksHelper
  def books_updated_today(user)
    @books_updated_today ||= user.books
      .where('updated_at > ?', Time.now - 1.days)
      .order(:created_at)
  end

end
