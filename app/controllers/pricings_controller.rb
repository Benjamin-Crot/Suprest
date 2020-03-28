class PricingsController < ApplicationController
  def index
    @account = Account.find(params[:account_id])
    @product = Product.find(params[:product_id])
    @pricings = policy_scope(@product.pricing).order(amount_cents: :asc)
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
    @pricing.amount_cents = (params[:pricing][:amount_cents].to_f * 100).to_i
    authorize @pricing
    if @pricing.save
      redirect_to account_product_pricings_path(@account, @product)
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
    @pricing.amount_cents = (params[:pricing][:amount_cents].to_f * 100).to_i
    @pricing.save
    redirect_to account_product_pricings_path(@account, @product)
  end

  # def hash_quantity(min, max, )
  #   if role.is_admin == true
  #     return "admin"
  #   else
  #     return "basic"
  #   end
  # end

  def destroy
    @pricing = Pricing.find(params[:id])
    @product = Product.find(@pricing.product_id)
    @account = Account.find(@product.account_id)
    authorize @pricing
    @pricing.destroy
    redirect_to account_product_pricings_path(@account, @product)
  end



  # helper_method :hash_quantity

  private

  def pricing_params
    strong_params = params.require(:pricing).permit(:amount_cents, :min_quantity, :max_quantity)
    # strong_params[:amount_cents] = (strong_params[:amount_cents].to_f * 100).to_i
  end
end
