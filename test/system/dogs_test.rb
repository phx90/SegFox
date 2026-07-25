require "application_system_test_case"

class DogsTest < ApplicationSystemTestCase
  setup do
    %w[seed1.jpg seed2.jpg].each do |filename|
      dogs(:one).images.attach(
        io: File.open(Rails.root.join("app/assets/images", filename), "rb"),
        filename: filename,
        content_type: "image/jpeg"
      )
    end
  end

  test "visitor navigates from the catalog to details" do
    visit dogs_url
    assert_selector "nav[aria-label='Navegação principal']"
    assert_selector "label", text: "Buscar por nome"
    assert_selector "label", text: "Raça"
    assert_text "Jade"
    assert_selector "button[aria-label='Próxima foto de Jade']"
    assert_selector "[data-carousel-target='slide']", count: 2, visible: :all
    find("button[aria-label='Próxima foto de Jade']").click
    assert_selector "img[alt='Jade — foto 2']:not(.hidden)"
    click_on "Ver detalhes", match: :first
    assert_text "Terrier Brasileiro"
  end
end
