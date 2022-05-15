class UserBooksSummary
  attr_accessor :user, :target_term

  def initialize(user, target_term)
    @user = user
    @target_term = target_term
  end

  def private_books
    filtered_private_books
      .order(:category_id)
      .group(:category)
      .sum(:amount)

  end

  def common_books
    filtered_common_books
      .order(:category_id)
      .group(:category)
      .sum(:amount)
  end

  private

  def filtered_private_books
    user.books
      .payments
      .without_transfer
      .privates
      .target_month(target_term.year, target_term.month)
  end

  def filtered_common_books
    user.books
      .payments
      .without_transfer
      .commons
      .target_month(target_term.year, target_term.month)
  end

end