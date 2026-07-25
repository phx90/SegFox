require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "renders home" do
    get root_url
    assert_response :success
  end

  test "renders about" do
    get about_url
    assert_response :success
  end

  test "renders breeds" do
    get breeds_url
    assert_response :success
  end
end
