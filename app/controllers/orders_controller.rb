class OrdersController < ApplicationController
  def index
    @account = Account.find(params[:account_id])
    @orders = Order.where(status: false, account_id: @account.id).to_a
    authorize @orders
    @items = raise
  end
    # @item.order_id = Order.find_or_create_by(status: false, account_id: params[:account_id].to_i, supplier: @product.account_id).id

end
