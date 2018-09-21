class Admin::DashboardsController < Admin::ApplicationController
  authorize_resource :class => false

  def index; end
end
