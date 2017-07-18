class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    order_data = order_params
    order_data['total_price'] = order_data['price'].to_i * order_data['quantity'].to_i
    Order.create!(order_data)
    begin
      customer = Stripe::Customer.create(
        :email => params["stripeEmail"],
        :source  => params["stripeToken"]
      )
      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => params['order']['price'].to_i * params['order']['quantity'].to_i * 100,
        :description => 'Customer Order',
        :currency    => 'inr'
      )

    rescue Stripe::CardError => e
      flash[:error] = e.message
    end
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