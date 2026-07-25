class Dog < ApplicationRecord
  has_many_attached :images, dependent: :destroy

  belongs_to :father, class_name: "Dog", optional: true, inverse_of: :fathered_children
  belongs_to :mother, class_name: "Dog", optional: true, inverse_of: :mothered_children

  has_many :fathered_children, class_name: "Dog", foreign_key: "father_id",
                               dependent: :restrict_with_exception, inverse_of: :father
  has_many :mothered_children, class_name: "Dog", foreign_key: "mother_id",
                               dependent: :restrict_with_exception, inverse_of: :mother

  validates :name, :breed, :birth_date, :description, presence: true
  validates :available, inclusion: { in: [ true, false ] }
  validates :images, attached: true,
                     content_type: [ "image/png", "image/jpeg", "image/webp" ],
                     size: { less_than: 5.megabytes },
                     limit: { min: 1, max: 4 }
  validate :parents_are_valid

  private

  def parents_are_valid
    errors.add(:father, "não pode ser o próprio cão") if father_id.present? && father_id == id
    errors.add(:mother, "não pode ser o próprio cão") if mother_id.present? && mother_id == id
    errors.add(:mother, "deve ser diferente do pai") if father_id.present? && father_id == mother_id
  end
end
