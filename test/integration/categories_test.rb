require 'test_helper'

class CategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = users(:admin)
    @user = users(:murakami)
    @category = categories(:daily_goods)
  end

  test "未ログイン状態でカテゴリ一覧ページを開いたらリダイレクトされること" do
    get categories_path
    assert_redirected_to login_url
  end

  test "一般ユーザーで閲覧できないこと" do
    log_in_as(@user)
    get categories_path
    assert_redirected_to root_url
  end

  test "ユーザー一覧ページが正常であること" do
    log_in_as(@admin_user)
    get categories_path
    assert_template 'categories/index'

    Category.all.each do |category|
      assert_select 'td', text: category.name
      assert_select 'a[href=?]', edit_category_path(category), text: "編集"
    end
  end

  test "異常な情報を送ったときのカテゴリ登録" do
    log_in_as(@admin_user)
    get new_category_path
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name:  "",
                                  is_tax: false,
                                  is_fixed: false,
                                  is_food: false } }
    end
    assert_template 'categories/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
    assert_select 'li', /カテゴリ名を入力してください/
  end

  test "正常な情報を送ったときのカテゴリ登録" do
    log_in_as(@admin_user)
    get new_category_path
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name:  "家賃",
                                         is_tax: false, is_fixed: true, is_food: false
                                  } }
    end
    follow_redirect!
    assert_template 'categories/index'
    assert_not flash.empty?
  end

  test "カテゴリ編集失敗" do
    log_in_as(@admin_user)
    get edit_category_path(@category)
    assert_template 'categories/edit'

    patch category_path(@category), params: { category: { name:  "",
                                             is_tax: false, is_fixed: true, is_food: false
                                          } }

    assert_template 'categories/edit'
    assert_select 'div#error_explanation', text: /エラーがみつかりました/
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end

  test "カテゴリ編集成功" do
    log_in_as(@admin_user)
    get edit_category_path(@category)
    assert_template 'categories/edit'
    name = '日用品'
    patch category_path(@category), params: { category: { name:  name,
                                            is_tax: false, is_fixed: false, is_food: false
                                          } }
    assert_not flash.empty?
    assert_redirected_to categories_path
    @category.reload
    assert_equal name,  @category.name
  end
end
