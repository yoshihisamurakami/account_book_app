require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin_user = users(:admin)
    @user = users(:murakami)
    @account = accounts(:yoshihisa_bank)
  end

  test "管理者以外はアクセスできないこと (new)" do
    log_in_as(@user)
    get new_account_path
    assert_redirected_to root_url
  end

  test "管理者はアクセスできること (new)" do
    log_in_as(@admin_user)
    get new_account_path
    assert_response :success
  end

  test "管理者以外はアクセスできないこと (create)" do
    log_in_as(@user)
    post accounts_path, params: { account: { name: 'X口座', comment: '' } }
    assert_redirected_to root_url
  end

  # 正常なパターンはintegration test にて
  # test "管理者はアクセスできること (create)" do
  #   log_in_as(@admin_user)
  #   post accounts_path, params: { account: { name: 'X口座', comment: '' } }
  #   follow_redirect!
  #   assert_template 'accounts/index'
  # end
  
  
  test "管理者以外はアクセスできないこと (index)" do
    log_in_as(@user)
    get accounts_path
    assert_redirected_to root_url
  end

  test "管理者はアクセスできること (index)" do
    log_in_as(@admin_user)
    get accounts_path
    assert_response :success
  end

  test "管理者以外はアクセスできないこと (edit)" do
    log_in_as(@user)
    get edit_account_path(@account)
    assert_redirected_to root_url
  end

  test "管理者はアクセスできること (edit)" do
    log_in_as(@admin_user)
    get edit_account_path(@account)
    assert_response :success
  end

  # test "管理者以外はアクセスできないこと (update)" do
  #  log_in_as(@user)
  #  patch edit_account_path(@account)
  #  assert_redirected_to root_url
  # end
  
end