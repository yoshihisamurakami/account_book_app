class TargetTermModel
  attr_accessor :year, :month

  def initialize(session)
    self.year  = session[:target_term_year] || default_year
    self.month = session[:target_term_month] || default_month
  end

  def lastday_of_month
    Date.new(year, month, -1).day
  end

  private

  def default_year
    Date.today.year
  end

  def default_month
    Date.today.month
  end
end
