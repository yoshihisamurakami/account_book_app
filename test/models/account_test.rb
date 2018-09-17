require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  def setup
    @account = Account.new(name: "佳久小口現金", comment: "")
  end
  
  test "正常であること" do
    assert @account.valid?
  end
  
  test "口座名が存在しないとエラー" do
    @account.name = "     "
    assert_not @account.valid?
  end
  
  test "口座名が長すぎたらエラー" do
    @account.name = "a" * 51
    assert_not @account.valid?
  end
  
  test "コメントが長すぎたらエラー" do
    @account.comment = "a" * 256
    assert_not @account.valid?
  end
end
