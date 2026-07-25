require "test_helper"

class DogsControllerTest < ActionDispatch::IntegrationTest
  test "lists only available dogs" do
    get dogs_url

    assert_response :success
    assert_select "h2", text: "Jade"
    assert_select "h2", text: "Thor", count: 0
  end

  test "filters by breed" do
    get dogs_url, params: { breed: "Pastor da Mantiqueira" }

    assert_response :success
    assert_select "p", text: /Nenhum cão disponível/
  end

  test "shows a dog" do
    get dog_url(dogs(:one))
    assert_response :success
  end

  test "paginates the catalog and preserves accessible navigation" do
    now = Time.current
    13.times do |index|
      Dog.insert!({
        name: "Disponível #{index}",
        description: "Cão criado para validar paginação.",
        breed: "Terrier Brasileiro",
        birth_date: Date.new(2023, 1, 1),
        available: true,
        created_at: now,
        updated_at: now
      })
    end

    get dogs_url
    assert_response :success
    assert_select "article", count: DogsController::PER_PAGE
    assert_select "nav[aria-label='Paginação do catálogo']"
    assert_select "a[rel='next']"

    get dogs_url, params: { page: 2 }
    assert_response :success
    assert_select "[aria-current='page']", text: /Página 2/
  end
end
