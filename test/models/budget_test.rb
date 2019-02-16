require 'test_helper'

class BudgetTest < ActiveSupport::TestCase
  def setup
    @budget = budgets(:january)
  end

  test "正常であること" do
    assert @budget.valid?
  end

  test "対象年が空だったらエラー" do
    @budget.target_year = nil
    assert_not @budget.valid?
  end

  test "対象年が文字列だったらエラー" do
    @budget.target_year = 'abc'
    assert_not @budget.valid?
  end

  test "対象年がマイナスの数値だったらエラー" do
    @budget.target_year = -1
    assert_not @budget.valid?
  end

  test "対象年がゼロだったらエラー" do
    @budget.target_year = 0
    assert_not @budget.valid?
  end

  test "対象年が小数だったらエラー" do
    @budget.target_year = 2.5
    assert_not @budget.valid?
  end
end
