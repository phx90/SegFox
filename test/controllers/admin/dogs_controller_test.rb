require "test_helper"

class AdminArea::DogsControllerTest < ActionDispatch::IntegrationTest
  test "redirects anonymous users" do
    get admin_area_dogs_url
    assert_redirected_to login_url
  end

  test "renders index for an admin" do
    sign_in_admin
    get admin_area_dogs_url
    assert_response :success
  end

  test "updates a dog" do
    sign_in_admin
    attach_image(dogs(:one))
    patch admin_area_dog_url(dogs(:one)), params: { dog: { name: "Jade II" } }

    assert_redirected_to admin_area_dogs_url
    assert_equal "Jade II", dogs(:one).reload.name
  end

  private

  def sign_in_admin
    post login_url, params: { email: admins(:one).email, password: "Password123!" }
  end

  def attach_image(dog)
    path = Rails.root.join("app/assets/images/seed1.jpg")
    dog.images.attach(io: File.open(path, "rb"), filename: "dog.jpg", content_type: "image/jpeg")
  end
end
