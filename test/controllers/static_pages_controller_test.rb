require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "/ にアクセスできること" do
    get root_path
    assert_response :success
    assert_select "title", "家計簿の入力 - 家計簿App"
  end

  test "/help ページにアクセスできること" do
    get help_path
    assert_response :success
    assert_select "title", "ヘルプ - 家計簿App"
  end

end
