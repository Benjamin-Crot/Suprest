class PricingsController < ApplicationController
  def index
    @account = Account.find(params[:account_id])
    @product = Product.find(params[:product_id])
    @pricings = policy_scope(@product.pricing).order(created_at: :asc)
  end

  def new
    @product = Product.find(params[:product_id])
    @pricing = Pricing.new
    authorize @pricing
  end

  def create
    @product = Product.find(params[:product_id])
    @account = Account.find(@product.account_id)
    @pricing = Pricing.new(pricing_params)
    @pricing.product_id = @product.id
    authorize @pricing
    if @pricing.save
      redirect_to account_path(@account)
    else
      render :new
    end
  end

  def edit
    @pricing = Pricing.find(params[:id])
    @product = Product.find(@pricing.product_id)
    authorize @pricing
  end

  def update
    @pricing = Pricing.find(params[:id])
    @product = Product.find(@pricing.product_id)
    @account = Account.find(@product.account_id)
    authorize @pricing
    @pricing.update(pricing_params)
    redirect_to account_product_pricings_path(@account, @product)
  end

  def destroy
    @pricing = Pricing.find(params[:id])
    @product = Product.find(@pricing.product_id)
    @account = Account.find(@product.account_id)
    authorize @pricing
    @pricing.destroy
    redirect_to account_product_pricings_path(@account, @product)
  end

  private

  def pricing_params
    strong_params = params.require(:pricing).permit(:amount_cents, :quantity, :product)
    # strong_params[:amount_cents] = (strong_params[:amount_cents].to_f * 100).to_i
  end
end
