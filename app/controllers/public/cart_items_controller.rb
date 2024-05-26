class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items.all
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if @cart_item.save
      redirect_to cart_items_path
    else
      @item = Item.find(params[:cart_item][:item_id])
      @cart_item = CartItem.new
      flash[:alert] = "数量を選択してください。"
      redirect_to request.referer
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(amount: params[:cart_item][:amount].to_i)
    redirect_to cart_items_path
    flash[:notice] = "#{@cart_item.item.name}の数量を変更しました！"
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:alert] = "#{@cart_item.item.name}を削除しました。"
    redirect_to cart_items_path
  end

  
  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
  
end
