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
    @orders_step_1 = @orders.filter_by_step("Validée")
    @orders_step_2 = @orders.filter_by_step("En cours de traitement")
    @orders_step_3 = @orders.filter_by_step("En cours de livraison")
    @orders_step_4 = @orders.filter_by_step("Livrée")
    # @steps = Step.where(name: "Validée")
    authorize @orders
  end

  def modal_details_orders_supplier
    @order = Order.find(params[:id])
    @step_new = Step.new
    authorize @order
    respond_to do |format|
      format.html
      format.js
    end
  end

  helper_method :total_order
end

# @account = Account.find(params[:account_id])
# @product = Product.find(params[:product_id])
# @pricings = policy_scope(@product.pricing).order(amount_cents: :asc)
