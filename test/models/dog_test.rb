require "test_helper"

class DogTest < ActiveSupport::TestCase
  test "requires core catalog fields" do
    dog = Dog.new(available: true)

    assert_not dog.valid?
    assert dog.errors.of_kind?(:name, :blank)
    assert dog.errors.of_kind?(:breed, :blank)
    assert dog.errors.of_kind?(:birth_date, :blank)
  end

  test "does not allow the same father and mother" do
    parent = dogs(:one)
    dog = dogs(:two)
    dog.father = parent
    dog.mother = parent

    assert_not dog.valid?
    assert dog.errors[:mother].present?
  end
end
