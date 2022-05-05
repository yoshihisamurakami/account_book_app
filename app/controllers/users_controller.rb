class UsersController < ApplicationController

  before_action :require_admin, only: [:index, :new, :create]
  before_action :require_admin_or_correct_user, only: [:edit, :update]
  before_action :require_logged_in, only: [:show]

  # GET /users   -> users_path
  def index
    @users = User.all.order(:id)
  end

  # GET /users/1  -> user_path(user)
  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:danger] = '指定したユーザーがみつかりません'
      redirect_to root_url
    end
    @target_term = TargetTermModel.new(session)
    @books = @user
      .books
      .target_month(@target_term.year, @target_term.month)
      .page(params[:page])
      .order(:books_date, :created_at)
    @user_books_view = UserBooksViewModel.new(@user, @target_term)
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
    @user = User.find(params[:id])
  end

  # PATCH /users/1  -> user_path(user)
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "更新されました。"
      redirect_to users_path
    else
      render 'edit'
    end
  end

  # DELETE users/1  -> user_path(user)
  # def destroy
  # end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def require_admin_or_correct_user
    @user = User.find(params[:id])
    if !user_session.logged_in?
      redirect_to login_url
    elsif !current_user&.admin? and current_user != @user
      redirect_to root_url
    end
  end

end
