# frozen_string_literal: true

module UsersHelper
  def user_photo(user, width = 250)
    if user.photo?
      concat image_tag user.image.url(:thumb), width: width, class: 'img-thumbnail'
    else
      concat image_tag 'noavatar.png', width: width, class: 'img-thumbnail'
    end
  end
end
