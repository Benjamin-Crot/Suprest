class ItemsController < ApplicationController
  def new
    @account = Account.find(params[:account_id])
    @product = Product.find(params[:product_id])
    @item = Item.new
    authorize @item
  end


  private

  def item_params
    params.require(:item).permit(:quantity, :price)
  end
end
