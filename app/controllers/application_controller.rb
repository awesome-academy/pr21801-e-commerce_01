class ApplicationController < ActionController::Base
  include RatingsHelper
  include CartsHelper

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_category
  before_action :load_cart
  before_action :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: "text/html" }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: "text/html" }
    end
  end

  protected

  def load_category
    @all_categories = Category.all_category
    @main_categories = Category.main_category
    @other_categories = Category.other_category
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :phone, :address])
  end

  def namespace
    controller_name_segments = params[:controller].split("/")
    controller_name_segments.pop
    controller_namespace = controller_name_segments.join("/").camelize
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, namespace)
  end

  def load_cart
    if session[:order]
      current_order
      total_cart
    end
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
