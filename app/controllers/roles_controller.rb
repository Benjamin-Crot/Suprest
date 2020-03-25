class RolesController < ApplicationController

  def new
    @user = current_user
    @role = Role.new
    authorize @role
    @account = Account.find(params[:account_id])
  end

  def create
    @role = Role.new(role_params)
    authorize @role

    if User.exists?(email: params[:role][:user])
      @account = Account.find(params[:account_id])
      @role.account_id = @account.id
      @role.user_id = User.find_by(email: params[:role][:user]).id
      if @role.save
        redirect_to root_path
      else
        render :new
      end
    else
      render :new
    end
  end

  def edit
    @role = Role.find(params[:id])
    @account = Account.find(params[:account_id])
    authorize @role
  end

  def update
    @role = Role.find(params[:id])
    authorize @role
    @account = Account.find(params[:account_id])

    if @role.update(role_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @role = Role.find(params[:id])
    role.destroy
    redirect_to root_path
  end

  def convert_is_admin_to_string(role)
    if role.is_admin == true
      return "admin"
    else
      return "basic"
    end
  end

  helper_method :convert_is_admin_to_string

  private

  def role_params
    params.require(:role).permit(:is_admin, :user, :account)
  end
end
