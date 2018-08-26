module RatingsHelper
  def calculate_average_rate product, count_rate
    total = product.ratings.pluck(:stars).sum
    average = total / count_rate
  end

  def rate(product)
    rating_id = product.ratings.find_by(user_id: current_user.id)
    rating_id ? rating_id.id : Settings.ratings.average
  end

  def star(product)
    rating_star = product.ratings.find_by(user_id: current_user.id)
    rating_star ? rating_star.stars : Settings.ratings.average
  end
end
