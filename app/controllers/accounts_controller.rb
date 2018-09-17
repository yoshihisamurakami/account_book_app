class AccountsController < ApplicationController
  before_action :require_admin, only: [:new, :create, :index, :edit, :update]
  
  def new
    @account = Account.new
  end
  
  def create
    @account = Account.new(account_params)
    if @account.save
      flash[:success] = "保存されました。"
      redirect_to accounts_path
    else
      render 'new'
    end
  end
  
  def index
    @accounts = Account.all
  end
  
  def edit
    @account = Account.find(params[:id])
  end
  
  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(account_params)
      flash[:success] = "口座情報が更新されました。"
      redirect_to accounts_path
    else
      render 'edit'
    end
  end
  
  def destroy
    Account.find(params[:id]).destroy
    flash[:success] = "削除されました。"
    redirect_to accounts_path
  end
  
  private 
  
    def account_params
      params.require(:account).permit(:name, :comment)
    end

end