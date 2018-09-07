class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :load_product

  def create
    @comment = @product.comments.create comment_params
    redirect_to product_path @product
  end

  def destroy
    if @comment.destroy
      flash[:success] = t "comment_deleted"
    else
      flash[:danger] = t "can_not_delete_comment"
    end
    redirect_to product_url @product
  end

  private

  def comment_params
    params.require(:comment).permit :product_id, :user_id, :content
  end

  def load_product
    redirect_to root_url unless @product = Product.find_by id: params[:product_id]
  end
end
