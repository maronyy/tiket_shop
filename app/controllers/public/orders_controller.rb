class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @adresses = Adress.where(customer: current_customer)
    if current_customer.cart_items.empty?
      redirect_to cart_items_path
    end
  end

  def show
  end

  def index
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @sum = 0
    @shipping_cost = 500
    if params[:order][:address_option] == "0"
      @order.adress = current_customer.adress
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:adress_option] == "1"
      @adress = Adress.find(params[:order][:address_id])
      @order.adress = @adress.adress
      @order.postal_code = @adress.postal_code
      @order.name = @adress.name
    elsif params[:order][:adress_option] == "2"
      if params[:order][:postal_code] != "" && params[:order][:adress] != "" && params[:order][:name] != ""
        @order.postal_code = params[:order][:postal_code]
        @order.adress = params[:order][:adress]
        @order.name = params[:order][:name]
      else
        flash[:alert] = "新しいお届け先が入力されていません"
        redirect_to new_order_path
      end
    end
  end
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.status = 0
    @cart_items = current_customer.cart_items.all
    if @cart_items.blank?
      flash[:alert] = "注文は確定しています"
      redirect_to root_path
    else
      @order.save
      @cart_items.each do |cart_item|
        @order_item = OrderItem.new
        @order_item.item_id = cart_item.item.id
        @order_item.order_id = @order.id
        @order_item.price = cart_item.item.price
        @order_item.amount = cart_item.amount
        @order_item.making_status = 0
        @order_item.save!
        current_customer.cart_items.destroy_all
      end
      redirect_to orders_complete_path
    end
  end


  def complete
  end
  
  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :adress, :name, :shipping_cost, :total_price, :order_status )
  end

end
