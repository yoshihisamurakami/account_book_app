module SessionsHelper
  def user_session
    @user_session ||= UserSession.new(session)
  end
end
