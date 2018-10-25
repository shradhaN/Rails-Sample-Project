class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size

  private

    # validates the size of the uploaded picture
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, 'hould be less than 5MB')
      end
    end
end
