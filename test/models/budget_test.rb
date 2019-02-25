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

  test "対象月が空だったらエラー" do
    @budget.target_month = nil
    assert_not @budget.valid?
  end

  test "対象月が文字列だったらエラー" do
    @budget.target_month = 'abc'
    assert_not @budget.valid?
  end

  test "対象月がマイナスの数値だったらエラー" do
    @budget.target_month = -1
    assert_not @budget.valid?
  end

  test "対象月がゼロだったらエラー" do
    @budget.target_month = 0
    assert_not @budget.valid?
  end

  test "対象月が小数だったらエラー" do
    @budget.target_month = 2.5
    assert_not @budget.valid?
  end

  # regular_income
  test "定期収入(regular_income)(毎月必ず入ってくる収入) 入力必須" do
    @budget.regular_income = nil
    assert_not @budget.valid?
  end
  test "定期収入(regular_income) 数値でなければエラー" do
    @budget.regular_income = 'abc'
    assert_not @budget.valid?
  end
  test "定期収入(regular_income) 0 はOK" do
    @budget.regular_income = 0
    assert @budget.valid?
  end
  test "定期収入(regular_income) マイナスはエラー" do
    @budget.regular_income = -1
    assert_not @budget.valid?
  end

  # extra_income 臨時収入: 不定期収入。バイト代など
  test "臨時収入(extra_income) 入力必須" do
    @budget.extra_income = nil
    assert_not @budget.valid?
  end
  test "臨時収入(extra_income) 数値でなければエラー" do
    @budget.extra_income = 'abc'
    assert_not @budget.valid?
  end
  test "臨時収入(extra_income) 0 はOK" do
    @budget.extra_income = 0
    assert @budget.valid?
  end
  test "臨時収入(extra_income) マイナスはエラー" do
    @budget.extra_income = -1
    assert_not @budget.valid?
  end

  # special_income(特別収入) 宝クジが当たった・親から貰った等
  test "special_income 入力必須" do
    @budget.special_income = nil
    assert_not @budget.valid?
  end
  test "special_income 数値でなければエラー" do
    @budget.special_income = 'abc'
    assert_not @budget.valid?
  end
  test "special_income 0 はOK" do
    @budget.special_income = 0
    assert @budget.valid?
  end
  test "special_income マイナスはエラー" do
    @budget.special_income = -1
    assert_not @budget.valid?
  end

  # tax_funding(税金支払用の積立金)
  test "tax_funding 入力必須" do
    @budget.tax_funding = nil
    assert_not @budget.valid?
  end
  test "tax_funding 数値でなければエラー" do
    @budget.tax_funding = 'abc'
    assert_not @budget.valid?
  end
  test "tax_funding 0 はOK" do
    @budget.tax_funding = 0
    assert @budget.valid?
  end
  test "tax_funding マイナスはエラー" do
    @budget.tax_funding = -1
    assert_not @budget.valid?
  end

  # special_funding(特別経費用の積立金)
  test "special_funding 入力必須" do
    @budget.special_funding = nil
    assert_not @budget.valid?
  end
  test "special_funding 数値でなければエラー" do
    @budget.special_funding = 'abc'
    assert_not @budget.valid?
  end
  test "special_funding 0 はOK" do
    @budget.special_funding = 0
    assert @budget.valid?
  end
  test "special_funding マイナスはエラー" do
    @budget.special_funding = -1
    assert_not @budget.valid?
  end

  # savings 貯蓄
  test "savings 入力必須" do
    @budget.savings = nil
    assert_not @budget.valid?
  end
  test "savings 数値でなければエラー" do
    @budget.savings = 'abc'
    assert_not @budget.valid?
  end
  test "savings 0 はOK" do
    @budget.savings = 0
    assert @budget.valid?
  end
  test "savings マイナスはエラー" do
    @budget.savings = -1
    assert_not @budget.valid?
  end

  # fixed_budget  固定費の予算
  test "fixed_budget 入力必須" do
    @budget.fixed_budget = nil
    assert_not @budget.valid?
  end
  test "fixed_budget 数値でなければエラー" do
    @budget.fixed_budget = 'abc'
    assert_not @budget.valid?
  end
  test "fixed_budget 0 はOK" do
    @budget.fixed_budget = 0
    assert @budget.valid?
  end
  test "fixed_budget マイナスはエラー" do
    @budget.fixed_budget = -1
    assert_not @budget.valid?
  end

end
