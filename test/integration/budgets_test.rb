require 'test_helper'

class BudgetsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:murakami)
    @budget = budgets(:january)
  end

  test "予算一覧ページが正常であること" do
    log_in_as(@user)
    get budgets_path
    assert_template 'budgets/index'

    Budget.all.each do |budget|
      assert_select 'td', text: budget.target_year.to_s + '-' + "%02d" % budget.target_month
      assert_select 'a[href=?]', edit_budget_path(budget), text: "編集"
      assert_select 'a[href=?]', budget_path(budget), text: "削除"
    end
  end

  test "異常な情報を送ったときの予算登録" do
    log_in_as(@user)
    assert_no_difference 'Budget.count' do
      post budgets_path, params: { budget:
      { target_year:  "",
        target_month: "",
       } }
    end
    assert_template 'budgets/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
    assert_select 'li', /対象年を入力してください/
  end

  test "正常な情報を送ったときの予算登録" do
    log_in_as(@user)
    assert_difference 'Budget.count', 1 do
      post budgets_path, params: { budget:
        { target_year: '2019',
          target_month: '03',
          regular_income: '200000',
          extra_income: '0',
          special_income: '0',
          tax_funding: '10000',
          special_funding: '10000',
          savings: '10000',
          fixed_budget: '50000',
        } }
    end
    follow_redirect!
    assert_template 'budgets/index'
    assert_not flash.empty?
  end

  test "予算編集失敗" do
    log_in_as(@user)
    get edit_budget_path(@budget)
    assert_template 'budgets/edit'

    patch budget_path(@budget), params: { budget:
      { target_year:  "",
        target_month: "",
      } }

    assert_template 'budgets/edit'
    assert_select 'div#error_explanation', text: /エラーがみつかりました/
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end

  test "予算編集成功" do
    log_in_as(@user)
    get edit_budget_path(@budget)
    assert_template 'budgets/edit'
    target_month = '03'
    patch budget_path(@budget), params: { budget: {
      target_month:  target_month,
    } }
    assert_not flash.empty?
    assert_redirected_to budgets_path
    @budget.reload
    assert_equal target_month,  "%02d" % @budget.target_month
  end

  test "予算削除成功" do
    log_in_as(@user)
    assert_difference 'Budget.count', -1 do
      delete budget_path(@budget)
    end
  end

end
