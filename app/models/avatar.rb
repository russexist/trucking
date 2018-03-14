class Avatar < ApplicationRecord
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_avatar
  
  belongs_to :user

  mount_uploader :image, AvatarUploader

  validates :image, presence: true

  def crop_avatar
    image.recreate_versions! if crop_x.present?
  end
end
