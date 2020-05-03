class OrdersController < ApplicationController
  layout "dashboard", only: [:list_orders]

  def index
    @account = Account.find(params[:account_id])
    @accounts = Account.joins(:roles).where("roles.user_id" => current_user.id)

    # @orders = Order.where(status: false, account_id: @account.id).to_a
    @orders = policy_scope(Order).where(status: false, account_id: @account.id).order(created_at: :desc)
    @items = Item.joins(:order, :product).where("orders.account_id" => current_user.id, "orders.status" => false)
    # authorize @items
  end

  def total_order(order)
    sum = 0
    order.items.each do |item|
      sum += item.amount_cents
    end
    return sum.fdiv(100)
  end

  def list_orders
    @account = Account.find(params[:account_id])
    @orders = Order.where(supplier: @account.id, status: true)
    authorize @orders
  end

  helper_method :total_order
end

# @account = Account.find(params[:account_id])
# @product = Product.find(params[:product_id])
# @pricings = policy_scope(@product.pricing).order(amount_cents: :asc)
