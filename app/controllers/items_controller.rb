class ItemsController < ApplicationController
  # def new
  #   @account = Account.find(params[:account_id])
  #   @product = Product.find(params[:product_id])
  #   @item = Item.new
  #   authorize @item
  # end

  def create
    @account = Account.find(params[:account_id])
    @product = Product.find(params[:product_id])
    @item = Item.new(item_params)
    authorize @item
    @item.quantity = params[:item][:quantity]
    @item.product_id = params[:product_id]
    if check_stock?(@product, @item.quantity)
      item_price(params[:item][:quantity].to_i)
      @item.order_id = Order.find_or_create_by(status: false, account_id: params[:account_id].to_i, supplier: @product.account_id).id
      if @item.save
        redirect_to account_product_path(@account, @product)
        flash[:success] = "Le produit a bien été ajouté à votre panier"
      else
        redirect_to account_product_path(@account, @product)
      end
    else
      redirect_to account_product_path(@account, @product)
      flash[:nostock] = "Limite du stock, produit restant (#{@product.stock})"
    end
  end

  def check_stock?(product, quantity)
    if product.stock >= quantity
      return true
    else
      return false
      flash[:nostock] = "Limite du stock, produit restant (#{product.stock})"
    end
  end

  def item_price(quantity)
    arrays = Pricing.where("product_id = '#{params[:product_id].to_i}'")
    hash_of_prices = {}
    arrays.map do |pricing|
      hash_of_prices[pricing.amount_cents] = [pricing.min_quantity, pricing.max_quantity]
    end

    hash_of_prices.each do |key, value|
      if quantity.between?(value.first, value.last)
        @item.amount_cents = (quantity * key)
      end
    end
  end

  def update
    @account = Account.find(params[:account_id])
    @product = Product.find(params[:product_id])
    @item.quantity = params[:item][:quantity]
    authorize @item
    @item.update(item_params)
  end

  def destroy
    @item = Item.find(params[:id])
    authorize @item
    @order = Order.find(@item.order_id)
    @account = Account.find(@order.account_id)
    @item.destroy
    redirect_to account_orders_path(@account)
  end


  helper_method :item_price, :check_stock

  private

  def item_params
    params.require(:item).permit(:quantity, :amount_cents)
  end
end
