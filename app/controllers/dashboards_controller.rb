class DashboardsController < ApplicationController

  def create
    @dashboard = Dashboard.new()
    authorize @dashboard
    @dashboard.user = current_user
    if @dashboard.save
      redirect_to dashboard_path(current_user)
    else
      raise
    end
  end

  def show
    @user = current_user
    @dashboard = @user.dashboard
    authorize @dashboard
    if @user.role == "Restaurateur"
      render "dashboard.restaurator"
    elsif @user.role == "Fournisseur"
      render "dashboard.supplier"
    end
  end
end
