class CommentsController < ApplicationController
  before_action :get_product
  before_action :correct_comment, only: :destroy

  def create
    @comment = @product.comments.create! comment_params
    redirect_to product_path(@product)
  end

  def destroy
    @comment.destroy
    redirect_to product_url(@product.id)
  end

  private

  def comment_params
    params.require(:comment).permit :product_id, :user_id, :content
  end

  def get_product
    @product = Product.find_by id: params[:product_id]
  end

  def correct_comment
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end
end
