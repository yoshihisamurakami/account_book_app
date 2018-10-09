require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:admin)
    @user = users(:murakami)
    @category = categories(:daily_goods)
  end
  
  test "管理者以外はアクセスできないこと (new)" do
    log_in_as(@user)
    get new_category_path
    assert_redirected_to root_url
  end

  test "管理者はアクセスできること (new)" do
    log_in_as(@admin_user)
    get new_category_path
    assert_response :success
  end

  test "管理者以外はアクセスできないこと (create)" do
    log_in_as(@user)
    post categories_path, params: { category: { name: 'X口座', comment: '' } }
    assert_redirected_to root_url
  end

  # 正常なパターンはintegration test にて
  # test "管理者はアクセスできること (create)" do
  # end
  
  
  test "管理者以外はアクセスできないこと (index)" do
    log_in_as(@user)
    get categories_path
    assert_redirected_to root_url
  end

  test "管理者はアクセスできること (index)" do
    log_in_as(@admin_user)
    get categories_path
    assert_response :success
  end

  test "管理者以外はアクセスできないこと (edit)" do
    log_in_as(@user)
    get edit_category_path(@category)
    assert_redirected_to root_url
  end

  test "管理者はアクセスできること (edit)" do
    log_in_as(@admin_user)
    get edit_category_path(@category)
    assert_response :success
  end

  test "管理者以外はアクセスできないこと (update)" do
    log_in_as(@user)
    patch category_path(@category), 
      params: {
        category: { 
          name: @category.name,
          is_tax: false,
          is_fixed: false,
          is_food: false,
        }
      }
    assert_redirected_to root_url
  end
  
end
