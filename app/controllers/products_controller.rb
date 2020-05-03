class ProductsController < ApplicationController
  layout "dashboard", only: [:my_products]

  def index
    @all_accounts = Account.all
    @accounts = Account.joins(:roles).where("roles.user_id" => current_user.id)
    @products = policy_scope(Product).order(created_at: :desc)
    @account = Account.find(params[:account_id])
    @orders = Order.where(status: false, account_id: @account.id)

    if params[:query]
      @products = Product.all.text(params[:query])
    end

    if params["search"]
      @products = Product.all.category(params["search"]["categories"]).entity(params["search"]["entity"])
    end

    if params[:query] && params["search"]
      @products = Product.all.text(params[:query]).category(params["search"]["categories"]).entity(params["search"]["entity"])
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def list_items
    Item.joins(:order).where("orders.status" => false, "orders.account_id" => @account.id)
  end

  def market
    # @accounts = Account.joins(:roles).where("roles.user_id" => current_user.id)
    # @products = policy_scope(Product).order(created_at: :desc)
    # authorize @products
    # @account = Account.find(params[:account_id])
    # @orders = Order.where(status: false, account_id: @account.id)

    @all_accounts = Account.all
    @accounts = Account.joins(:roles).where("roles.user_id" => current_user.id)
    @products = policy_scope(Product).order(created_at: :desc)
    authorize @products
    @account = Account.find(params[:account_id])
    @orders = Order.where(status: false, account_id: @account.id)

    if params[:query]
      @products = Product.all.search_by_text(params[:query])
    end

    if params["search"]
      # @products = Product.all
      @products = Product.all.category(params["search"]["categories"]).entity(params["search"]["entity"])
    # else
    #   @products = Product.all
    end
  end

  def first_price(product)
    Pricing.where(product_id: product).order(amount_cents: :desc).last.amount_cents.fdiv(100)
  end

  def my_products
    @account = Account.find(params[:account_id])
    @products = Product.where("account_id" == @account.id)
    authorize @products
  end

  def home
  end

  def new
    @accounts = Account.joins(:roles).where("roles.user_id" => current_user.id)
    @account = Account.find(params[:account_id])
    @product = Product.new
    authorize @product
  end

  def create
    @account = Account.find(params[:account_id])
    @product = Product.new(product_params)
    raise
    @product.account_id = @account.id
    authorize @product
    if @product.save
      redirect_to new_product_pricing_path(@product)
    else
      render :new
    end
  end

  def show
    @accounts = Account.joins(:roles).where("roles.user_id" => current_user.id)
    @product = Product.find(params[:id])
    @account = Account.find(params[:account_id])
    @pricings = Pricing.where(product_id: @product).order(amount_cents: :desc)
    @item = Item.new
    @orders = Order.where(status: false, account_id: @account.id)
    authorize @product
  end

  def edit
    @accounts = Account.joins(:roles).where("roles.user_id" => current_user.id)
    @product = Product.find(params[:id])
    @account = Account.find(@product.account_id)
    authorize @product
  end

  def update
    @product = Product.find(params[:id])
    @account = Account.find(@product.account_id)
    authorize @product
    @product.update(product_params)
    redirect_to account_path(@account)
  end

  def destroy
    @account = Account.find(params[:account_id])
    @product = Product.find(params[:id])
    authorize @product
    @product.destroy
    redirect_to account_path(@account)
  end

  def total_order(order)
    sum = 0
    order.items.each do |item|
      sum += item.amount_cents
    end
    return sum.fdiv(100)
  end

  helper_method :first_price, :total_order, :list_items

  private

  def product_params
    params.require(:product).permit(:name, :description, :stock, :category, :entity, :photo, :account, :category_list)
  end
end
