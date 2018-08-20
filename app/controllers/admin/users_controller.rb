class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @q = User.ransack params[:q]
    @users = @q.result(distinct: true).page params[:page]
  end

  def destroy
    @user = User.find_by id: params[:id]
    if @user.destroy
      redirect_to admin_users_path, notice: t("user_deleted")
    else
      redirect_to admin_users_path,
        flash: { error: t("user_could_not_be_deleted") }
    end
  end
end
