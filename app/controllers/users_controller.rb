class UsersController < ApplicationController
  
  # GET /users   -> users_path
  def index
  end
  
  # GET /users/1  -> user_path(user)
  def show
  end
  
  # GET /users/new  -> new_user_path
  def new
    @user = User.new
  end
  
  # POST /users  -> users_path
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "正常に保存されました。"
      redirect_to users_url
    else
      render 'new'
    end
  end
  
  # GET /users/1/edit  -> edit_user_path(user)
  def edit
  end
  
  # PATCH /users/1  -> user_path(user)
  def update
  end
  
  # DELETE users/1  -> user_path(user)
  def destroy
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, 
                                 :password_confirmation)
  end
end
