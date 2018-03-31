# frozen_string_literal: true

class Avatar < ApplicationRecord
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  belongs_to :user

  validates :image, presence: true

  after_update :crop_avatar

  mount_uploader :image, AvatarUploader

  def crop_avatar
    image.recreate_versions! if crop_x.present?
  end
end
