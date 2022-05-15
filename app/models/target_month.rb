class TargetMonth
  attr_accessor :session

  def initialize(session)
    @session = session
  end

  def year
    session[:target_term_year] || Date.today.year
  end

  def month
    session[:target_term_month] || Date.today.month
  end

  def move_to_prev_month!
    prev_month_first_day = first_day.prev_month
    session[:target_term_year]  = prev_month_first_day.year
    session[:target_term_month] = prev_month_first_day.month
  end

  def move_to_next_month!
    next_month_first_day = first_day.next_month
    session[:target_term_year]  = next_month_first_day.year
    session[:target_term_month] = next_month_first_day.month
  end

  def lastday_of_month
    Date.new(year, month, -1).day
  end

  private

  def first_day
    Date.new(year, month, 1)
  end

end