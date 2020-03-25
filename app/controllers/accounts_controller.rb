class AccountsController < ApplicationController

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
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def account_params
    params.require(:account).permit(:name, :address, :category)
  end

end
