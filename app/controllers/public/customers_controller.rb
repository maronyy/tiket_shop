class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
  end

  def update
  end
  
  def unsubscribe
    @customer = Customer.find(params[:id])
    @customer.update(is_active: false)
    flash[:notice] = "ご利用ありがとうございました。"
    redirect_to root_path
  end

end
