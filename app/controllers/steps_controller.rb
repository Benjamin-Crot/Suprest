class StepsController < ApplicationController

  def create
    @order = Order.find(params[:order_id])
    @account = Account.find(@order.account_id)
    @step = Step.new
    authorize @step
    @step.order_id = @order.id

    if @order.steps.empty?
      @step.name = "Validée"
      if @step.save
        @order.status = true
        @order.save
        @order.items.map do |item|
          @product = Product.find(item.product_id)
          @product.stock -= item.quantity
        end
        redirect_to account_path(@account)
      end
    else
      @step.name = step_params[:name]
      @step.save
    end
  end

  private

  def step_params
    params.require(:step).permit(:name)
  end
end
