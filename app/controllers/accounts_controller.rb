class AccountsController < ApplicationController

  layout "dashboard", only: [:show, :edit, :customers]

  def index
  end

  def new
    @accounts = Account.joins(:roles).where("roles.user_id" => current_user.id)
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
      redirect_to account_path(@account)
    else
      render :new
    end
  end

  def show
    @roles = Role.where(user: current_user)
    @accounts = Account.joins(:roles).where("roles.user_id" => current_user.id)
    authorize @accounts
    @account = Account.find(params[:id])
    authorize @account
    @orders = Order.where(supplier: @account.id, status: true)
    @turnover = Item.joins(:order).where(orders: { status: true }).sum(:amount_cents).fdiv(100)
    @average_cart = @turnover.fdiv(@orders.count)
    @customer_count = @orders.uniq.pluck(:account_id).count


    if @account.category == "Fournisseur"
      @partial = "supplier"
    else
      @partial = "restaurator"
    end

  end

  def edit
    @accounts = Account.joins(:roles).where("roles.user_id" => current_user.id)
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
    @accounts = Account.joins(:roles).where("roles.user_id" => current_user.id)
    @roles = Role.where("account_id" == @account.id)
  end

  def convert_is_admin_to_string(role)
    if role.is_admin == true
      return "admin"
    else
      return "basic"
    end
  end

  def modal_choice_account
    @accounts = Account.joins(:roles).where("roles.user_id" => current_user.id)
    authorize @accounts
    respond_to do |format|
      format.html
      format.js
    end
  end

  def customers
    @account = Account.find(params[:id])
    authorize @account
    @accounts = Account.joins(:orders).where("orders.supplier" => current_user.id, "orders.status" => true)
  end

  helper_method :list_users_roles, :convert_is_admin_to_string

  private

  def account_params
    params.require(:account).permit(:name, :address, :category, :photo)
  end

end
