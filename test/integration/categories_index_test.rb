require 'test_helper'

class CategoriesIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = users(:admin)
    @user = users(:murakami)
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
end
