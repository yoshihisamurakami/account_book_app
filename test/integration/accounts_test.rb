require 'test_helper'

class AccountsTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:admin)
    @user = users(:murakami)
  end
  
  test "口座一覧ページが正常であること" do
    log_in_as(@admin_user)
    get accounts_path
    assert_template 'accounts/index'
    
    Account.all.each do |account|
      assert_select 'td', text: account.name
      assert_select 'a[href=?]', edit_account_path(account), text: "編集"
    end
  end
  
  test "異常な情報を送ったときの口座登録" do
    log_in_as(@admin_user)
    get new_account_path
    assert_no_difference 'Account.count' do
      post accounts_path, params: { account: { name:  "",
                                         comment: "",
                                  } }
    end
    assert_template 'accounts/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
    assert_select 'li', /口座名を入力してください/
  end
  
  test "正常な情報を送ったときの口座登録" do
    log_in_as(@admin_user)
    get new_account_path
    assert_difference 'Account.count', 1 do
      post accounts_path, params: { account: { name:  "テスト口座",
                                         comment: "",
                                  } }
    end
    follow_redirect!
    assert_template 'accounts/index'
    assert_not flash.empty?
  end
end
