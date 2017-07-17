class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    # TODO: Create a new order for the spcified user/service.
    # Redirect to an appropriate page if save fails.
    params = order_params
    params[:total_price]  = params[:price].to_i * params[:quantity].to_i
    Order.create!(params)
    redirect_to '/user_orders'
  end


  def user_orders
  @orders = current_user.orders.includes(:service)
  end

  def order_params
  	params[:order][:user_id] = current_user.id
  	params.require(:order).permit(:service_id, :price, :quantity, :user_id)
  end

end