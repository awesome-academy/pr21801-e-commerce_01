class RatingsController < ApplicationController
  before_action :authenticate_user!

  def create
    rating = current_user.ratings.new rating_params

    if rating.save
      update_average
      render json: {rating: {id: rating.id, stars: rating.stars}}
    else
      error_msg = t "create_failed"
      render json: {response_text: error_msg}
    end
  end

  def update
    rating = Rating.find_by id: params[:id]

    if rating.update_attributes rating_params
      update_average
      render json: {rating: {id: rating.id, stars: rating.stars}}
    else
      error_msg = t "update_failed"
      render json: {response_text: error_msg}
    end
  end

  private

  def update_average
    product = Product.find_by id: params[:rating][:product_id]
    count_rate = product.ratings.count
    product.update_attributes average_rating: calculate_average_rate(product,
      count_rate)
  end

  def rating_params
    params.require(:rating).permit :stars, :product_id
  end
end
