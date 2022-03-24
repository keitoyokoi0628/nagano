class Admin::OrderController < ApplicationController
  layout 'admin'
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def index
  end
end
