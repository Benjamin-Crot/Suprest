class ProductsController < ApplicationController

  def index
    @products = policy_scope(Product).order(created_at: :desc)
    @account = Account.find(params[:account_id])
  end

  def my_products
    @account = Account.find(params[:account_id])
    @products = Product.where("account_id" == @account.id)
    authorize @products
  end

  def new
    @account = Account.find(params[:account_id])
    @product = Product.new
    authorize @product
  end

  def create
    @account = Account.find(params[:account_id])
    @product = Product.new(product_params)
    @product.account_id = @account.id
    authorize @product
    if @product.save
      redirect_to new_product_pricing_path(@product)
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @account = Account.find(params[:account_id])
    authorize @product
  end

  def edit
    @product = Product.find(params[:id])
    @account = Account.find(@product.account_id)
    authorize @product
  end

  def update
    @account = Account.find(params[:account_id])
    @product = Product.find(params[:id])
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

  # def pricing
  #   @product = Product.find(params[:id])
  #   authorize @product
  #   @product.destroy
  #   redirect_to account_path(@account)
  # end

  private

  def product_params
    params.require(:product).permit(:name, :description, :stock, :category, :entity, :photo, :account)
  end
end
