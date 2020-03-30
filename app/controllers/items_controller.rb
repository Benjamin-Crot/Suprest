class ItemsController < ApplicationController
  def new
    @account = Account.find(params[:account_id])
    @product = Product.find(params[:product_id])
    @item = Item.new
    authorize @item
  end

  def create
    @account = Account.find(params[:account_id])
    @product = Product.find(params[:product_id])
    @item = Item.new(item_params)
    authorize @item
    @item.quantity = params[:item][:quantity]
    @item.product_id = params[:product_id]
    item_price(params[:item][:quantity].to_i)

    # # if Order.where(["status = ? and account_id = ? and supplier = ?", "#{false}", "#{params[:account_id].to_i}", "#{@product.account_id}"]).empty?
    # if Order.where(status: false, account_id: params[:account_id].to_i, supplier: @product.account_id).exists?
    #   @item.order_id = Order.where(status: false, account_id: params[:account_id].to_i, supplier: @product.account_id).last.id
    # else
    #   raise
    #   Order.create!(account: @account, supplier: @product.account_id)
    # end

    @item.order_id = Order.find_or_create_by(status: false, account_id: params[:account_id].to_i, supplier: @product.account_id).id


    # @item.order_id = Order.find(["status = ? and account_id = ? and supplier = ?", "#{false}", "#{params[:account_id].to_i}", "#{@product.account_id}"]).id

    if @item.save
      redirect_to account_products_path(@account)
    else
      render :new
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
      # else render :new
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

  helper_method :item_price

  private

  def item_params
    params.require(:item).permit(:quantity, :amount_cents)
  end
end
