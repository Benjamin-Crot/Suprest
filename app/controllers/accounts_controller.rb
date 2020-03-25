class AccountsController < ApplicationController

  def index
  end

  def new
    @account = Account.new
    authorize @account
  end

  def create
    @account = Account.new(account_params)
    @user = current_user
    authorize @account
    if @account.save
      # @is_admin = true
      Role.create!(user: @user, account: @account, is_admin: true)
      Dashboard.create!(account: @account)
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @account = Account.find(params[:id])
    authorize @account
  end

  def edit
    @account = Account.find(params[:id])
    authorize @account
  end

  def update
    @account = Account.find(params[:id])
    authorize @account
    @account.update(account_params)
    render :edit
  end

  def destroy
    @account = Account.find(params[:id])
    authorize @account
    @account.destroy
    redirect_to root_path
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

  helper_method :list_users_roles, :convert_is_admin_to_string

  private

  def account_params
    params.require(:account).permit(:name, :address, :category)
  end

end
