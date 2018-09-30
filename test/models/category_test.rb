require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: "日用雑貨", is_tax: false, is_fixed: false, is_food: false)
  end
  
  test "正常であること" do
    assert @category.valid?
  end
  
  test "カテゴリ名が存在しないとエラー" do
    @category.name = "     "
    assert_not @category.valid?
  end

  test "カテゴリ名が長すぎたらエラー" do
    @category.name = "a" * 256
    assert_not @category.valid?
  end
end
