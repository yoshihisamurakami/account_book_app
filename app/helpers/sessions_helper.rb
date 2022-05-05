module SessionsHelper

  # 現在ログイン中のユーザーを返す (いる場合)
  # MEMO: 2022-05-05 application_controller.rbにも同じメソッドがある そのうち直す
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  # MEMO: 2022-05-05 application_controller.rbにも同じメソッドがある そのうち直す
  def logged_in?
    !current_user.nil?
  end

end
