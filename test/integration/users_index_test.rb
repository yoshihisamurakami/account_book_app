require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  test "ユーザー一覧ページが正常であること" do
    # log_in_as(@user)
    get users_path
    assert_template 'users/index'
    
    User.all.each do |user|
      assert_select 'td', text: user.name
      assert_select 'a[href=?]', edit_user_path(user), text: "編集"
    end
  end
end
