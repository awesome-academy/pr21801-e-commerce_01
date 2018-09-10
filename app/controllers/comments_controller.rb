class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :load_product

  def create
    if params[:comment][:parent_id].present?
      parent = Comment.find_by id: params[:comment][:parent_id]
      return unless parent
      @comment = parent.children.build comment_params
    else
      @comment = Comment.new comment_params
    end

    respond_to do |format|
      if @comment.save
        format.html {flash[:success] = t "comment_added"}
        format.js
      else
        format.html {flash[:danger] = t "add_comment_failed"}
      end
      format.html {redirect_to product_path @product}
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      @comment.descendants.destroy_all
      @comment.destroy
      respond_to do |format|
        format.html {
          flash[:success] = t "comment_deleted"
          redirect_to product_url @product
        }
        format.js
      end
    end
    rescue
      flash[:danger] = t "can_not_delete_comment"
      redirect_to product_url @product
  end

  private

  def comment_params
    params.require(:comment).permit :product_id, :user_id, :content, :parent_id
  end

  def load_product
    redirect_to root_url unless @product = Product.find_by(id: params[:product_id])
  end
end
