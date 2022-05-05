class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    user_session.current_user
  end

  def require_logged_in
    unless user_session.logged_in?
      redirect_to login_url
    end
  end

  def require_admin
    if !user_session.logged_in?
      redirect_to login_url
    elsif !current_user&.admin?
      redirect_to root_url
    end
  end

  def user_session
    @user_session ||= UserSession.new(session)
  end
end
