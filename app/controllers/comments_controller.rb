class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :load_product

  def new
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  def create
    if params[:comment][:parent_id]
      parent = Comment.find_by id: params[:comment][:parent_id]
      return unless parent
      @comment = parent.children.build comment_params
    else
      @comment = Comment.new comment_params
    end

    if @comment.save
      flash[:success] = t "comment_added"
    else
      flash[:danger] = t "add_comment_failed"
    end
    redirect_to product_path @product
  end

  def destroy
    ActiveRecord::Base.transaction do
      @comment.descendants.destroy_all
      @comment.destroy
      flash[:success] = t "comment_deleted"
      redirect_to product_url @product
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
