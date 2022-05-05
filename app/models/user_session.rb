class UserSession
  attr_reader :session

  def initialize(session)
    @session = session
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

end
