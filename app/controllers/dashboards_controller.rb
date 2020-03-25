class DashboardsController < ApplicationController

  # def create
  #   @dashboard = Dashboard.new()
  #   authorize @dashboard
  #   @dashboard.user = current_user
  #   if @dashboard.save
  #     redirect_to dashboard_path(current_user)
  #   else
  #     raise
  #   end
  # end



  def welcome
    @user = current_user
    @dashboard = @user.dashboard
    authorize @dashboard
  end

  def show
    @user = current_user
    @dashboard = @user.dashboard
    authorize @dashboard

    if @user.roles.first.account.category == "Fournisseur"
      @account = @user.roles.first.account
        render "dashboard.supplier"
    elsif @user.roles.first.account.category == "Restaurateur"
        render "dashboard.restaurator"
    else
      render welcome_dashboards
    end
  end

  def list_users_roles
    @roles = Role.where("account_id" == @account.id)
  end

  def convert_is_admin_to_string(role)
    if role.is_admin == true
      return "admin"
    else
      return "basic"
    end
  end

  def is_admin?
    @role = Role.where("account_id" == @account_id, "user_id" == current_user.id).first
    @role.is_admin
  end

  helper_method :list_users_roles, :convert_is_admin_to_string, :is_admin?

end
