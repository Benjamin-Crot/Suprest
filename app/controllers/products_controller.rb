class ProductsController < ApplicationController
  def new
    @user = current_user
    @supplier = @user.suppliers.first
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    @user = current_user
    @supplier = @user.suppliers.first
    @supplier = Supplier.find(params[:supplier_id])
    @product.supplier_id = @supplier.id
    authorize @product
    if @product.save
      redirect_to root_path
    else
      raise
      render :new
    end
  end

  def show
    @supplier = Supplier.find(params[:id])
    authorize @supplier
  end

  def edit
    @supplier = Supplier.find(params[:id])
    authorize @supplier
    @supplier.user = current_user
  end

  def update
    @supplier = Supplier.find(params[:id])
    authorize @supplier
    @supplier.update(supplier_params)
    redirect_to root_path
  end

  def destroy
    @supplier = Supplier.find(params[:id])
    authorize @supplier
    @supplier.destroy
    redirect_to root_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :stock)
  end
end
