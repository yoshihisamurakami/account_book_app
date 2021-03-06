module SessionsHelper
  
  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def require_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def require_admin
    if !logged_in?
      redirect_to login_url
    elsif !@current_user.admin?
      redirect_to root_url
    end
  end
end
