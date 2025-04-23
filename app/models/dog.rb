class Dog < ApplicationRecord
  has_many_attached :images

  validates :images, presence: true
  validate :images_count_within_bounds

  def images_count_within_bounds
    if images.attached? && (images.count < 1 || images.count > 4)
      errors.add(:images, "must have between 1 and 4 files")
    end
  end
end
