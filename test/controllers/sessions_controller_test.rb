require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "renders login" do
    get login_url
    assert_response :success
  end

  test "authenticates an admin" do
    post login_url, params: { email: admins(:one).email, password: "Password123!" }

    assert_redirected_to admin_area_dogs_url
  end

  test "rejects invalid credentials" do
    post login_url, params: { email: admins(:one).email, password: "wrong" }

    assert_response :unprocessable_content
  end

  test "logs out" do
    post login_url, params: { email: admins(:one).email, password: "Password123!" }
    delete logout_url

    assert_redirected_to root_url
  end
end
