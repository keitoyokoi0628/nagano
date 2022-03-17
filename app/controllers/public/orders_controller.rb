class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.save!
    # 商品の保存方法を記述？SEEDと同じ要領？商品詳細
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.order_id = @order.id
      @order_detail.price = cart_item.item.add_tax_price
      @order_detail.amount = cart_item.amount
      @order_detail.is_active = "b"
      @order_detail.save!
    end

    redirect_to thanks_path
  end

  def confirm
    @cart_items = current_customer.cart_items
    params[:order][:address_id] = params[:order][:address_id].to_i
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_cost = 800
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "2"
      @address = Address.new
      @address.name = params[:order][:name]
      @address.postal_code = params[:order][:postal_code]
      @address.address = params[:order][:address]
      @address.customer_id = current_customer.id
      @address.save!
    end
  end

  def thanks
  end

  def index
    @orders = current_customer.orders
    @order_details = OrderDetail.all
  end

  def show
  end

  private

  def order_params
   params.require(:order).permit(:customer_id, :payment_method, :address, :postal_code, :name, :shipping_cost, :total_payment)
  end

  def address_params
   params.require(:order).permit(:address, :postal_code, :name)
  end

end