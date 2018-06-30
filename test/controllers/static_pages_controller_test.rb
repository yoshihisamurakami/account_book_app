require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "/ にアクセスできること" do
    get root_path
    assert_response :success
  end

  test "/help ページにアクセスできること" do
    get help_path
    assert_response :success
  end

end
