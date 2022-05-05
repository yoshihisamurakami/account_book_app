class SessionsController < ApplicationController
  def new; end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      user_session.log_in user
      redirect_to root_url
    else
      flash.now[:danger] = 'メールアドレスとパスワードの組み合わせが正しくありません'
      render :new
    end
  end
  
  def destroy
    user_session.log_out
    redirect_to root_url
  end

end
