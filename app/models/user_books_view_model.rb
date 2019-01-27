class UserBooksViewModel
  attr_accessor :user, :target_term

  def initialize(user, target_term)
    self.user = user
    self.target_term = target_term
  end

  def private_books
    _private_books.order(:category_id).group(:category).sum(:amount)
  end

  def common_books
    _common_books.order(:category_id).group(:category).sum(:amount)
  end

  private

  def _private_books
    self.user.books
      .payments
      .without_transfer
      .privates
      .get_all_on_target_month(self.target_term.year, self.target_term.month)
  end

  def _common_books
    self.user.books
      .payments
      .without_transfer
      .commons
      .get_all_on_target_month(self.target_term.year, self.target_term.month)
  end

end