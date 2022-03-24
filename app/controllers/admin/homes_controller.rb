class Admin::HomesController < ApplicationController
  layout 'admin'
  def top
    @orders = Order.all
    @order_details = OrderDetail.all
  end
end
