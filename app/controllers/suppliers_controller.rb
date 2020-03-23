class SuppliersController < ApplicationController

  def new
    @user = current_user
    @supplier = Supplier.new
    authorize @supplier
  end

  def create
    @supplier = Supplier.new(supplier_params)
    authorize @supplier

    @supplier.user = current_user

    if @supplier.save
      redirect_to root_path
    else
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

  def supplier_params
    params.require(:supplier).permit(:name, :address, :user)
  end
end
