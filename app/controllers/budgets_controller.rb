class BudgetsController < ApplicationController
  before_action :require_logged_in

  def new
  end

  def index
    @budgets = Budget.all
      .order(:target_year, :target_month)
  end

end