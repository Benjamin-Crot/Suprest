class StepsController < ApplicationController
  def create
    @order = Order.find(params[:order_id])
    @account = Account.find(@order.account_id)
    @step = Step.new
    @step.name = "Validée"
    @step.order_id = @order.id
    authorize @step
    if @step.save
      @order.status = true
      @order.save
      @order.items.map do |item|
        @product = Product.find(item.product_id)
        @product.stock -= item.quantity
      end
      redirect_to account_path(@account)
    end
  end

  # private

  # def step_params
  #   params.require(:step).permit(:name, :date)
  # end
end