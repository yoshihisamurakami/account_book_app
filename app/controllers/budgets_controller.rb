class BudgetsController < ApplicationController
  before_action :require_logged_in

  def new
    @budget = Budget.new
  end

  def create
    @budget = Budget.new(budget_params)
    if @budget.save
      flash[:success] = "保存されました。"
      redirect_to budgets_path
    else
      render 'new'
    end
  end

  def index
    @budgets = Budget.all
      .order(:target_year, :target_month)
  end

  def edit
    @budget = Budget.find(params[:id])
  end

  def update
    @budget = Budget.find(params[:id])
    if @budget.update(budget_params)
      flash[:success] = "予算が更新されました。"
      redirect_to budgets_path
    else
      render 'edit'
    end
  end

  def destroy
    Budget.find(params[:id]).destroy
    flash[:success] = "削除されました。"
    redirect_to budgets_path
  end

  private

  def budget_params
    params.require(:budget).permit(
      :target_year,
      :target_month,
      :regular_income,
      :extra_income,
      :special_income,
      :tax_funding,
      :special_funding,
      :savings,
      :fixed_budget
    )
  end
end