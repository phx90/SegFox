class DogParent < ApplicationRecord
    belongs_to :parent, class_name: "Dog"
  belongs_to :child,  class_name: "Dog"
end
