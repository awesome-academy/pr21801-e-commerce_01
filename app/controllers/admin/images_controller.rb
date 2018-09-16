class Admin::ImagesController < Admin::ApplicationController
  load_and_authorize_resource

  def destroy
    @image = Image.find_by id: params[:id]
    if @image.destroy
      flash[:success] = t "image_deleted"
    else
      flash[:danger] = t "delete_image_failed"
    end
    redirect_back fallback_location: admin_category_url(@image.product.category)
  end
end
