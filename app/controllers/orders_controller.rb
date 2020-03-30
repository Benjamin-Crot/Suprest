class OrdersController < ApplicationController
  def index
    @account = Account.find(params[:account_id])
    @orders = Order.where(status: false, account_id: @account.id).to_a
    authorize @orders
  end


end
