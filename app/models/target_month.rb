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

  def lastday_of_month
    Date.new(year, month, -1).day
  end

end