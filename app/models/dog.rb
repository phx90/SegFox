class Dog < ApplicationRecord
  has_many_attached :images

  belongs_to :father, class_name: "Dog", optional: true
  belongs_to :mother, class_name: "Dog", optional: true

  has_many :fathered_children, class_name: "Dog", foreign_key: "father_id"
  has_many :mothered_children, class_name: "Dog", foreign_key: "mother_id"

  has_many :parent_links, class_name: "DogParent", foreign_key: "child_id"
  has_many :parents, through: :parent_links, source: :parent
  has_many :child_links, class_name: "DogParent", foreign_key: "parent_id"
  has_many :children, through: :child_links, source: :child

  validates :name, :breed, presence: true
  validates :images, presence: true
  validate :images_count_within_bounds

  def images_count_within_bounds
    if images.attached? && (images.count < 1 || images.count > 4)
      errors.add(:images, "must have between 1 and 4 files")
    end
  end
end
