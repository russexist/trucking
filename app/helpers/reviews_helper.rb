module ReviewsHelper
  def rating_for_user(user)
    reviews = Review.for_driver(user)
    return if reviews.sum(&:rating) == 0
    rating = reviews.sum(&:rating)/reviews.count
    show_rating(rating)
  end

  def show_rating(count)
    count.times { concat image_tag 'star.png' }
    (5-count).times { concat image_tag 'star.png', class: 'star-gray' }
    return
  end
end
