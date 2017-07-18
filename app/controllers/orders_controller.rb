class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    Order.create!(order_params)
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
    params[:order][:total_price] = params[:order]['price'].to_i * params[:order]['quantity'].to_i
  	params.require(:order).permit(:service_id, :price, :quantity, :user_id, :total_price)
  end
end
