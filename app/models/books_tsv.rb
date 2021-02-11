class BooksTsv

  def initialize(year)
    @year = year
  end

  def get
    tsv_data = CSV.generate(:col_sep => "\t") do |tsv|
      tsv << header
      target_books.each do |book|
        tsv << line(book)
      end
    end
    tsv_data
  end

  private

  def target_books
    Book
      .eager_load(:user, :account, :category)
      .target_year(@year)
      .order(:books_date, 'books.created_at')
  end

  def header
    %W(id books_date user_id user_name account_id account_name
       deposit transfer category_id category_name summary amount
       common business special created_at updated_at)
  end

  def line(book)
    [
      book.id,
      book.books_date,
      book.user_id,
      book.user_name,
      book.account_id,
      book.account_name,
      book.deposit,
      book.transfer,
      book.category_id,
      book.category_name,
      book.summary,
      book.amount,
      book.common,
      book.business,
      book.special,
      book.created_at,
      book.updated_at
    ]
  end
end
