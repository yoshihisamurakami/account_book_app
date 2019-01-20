module BooksHelper
  def books_updated_today(user, params)
    @books_updated_today ||= user.books
      .where('updated_at > ?', Time.now - 1.days)
      .order(:created_at)
      .paginate(page: params[:page])
  end
end
