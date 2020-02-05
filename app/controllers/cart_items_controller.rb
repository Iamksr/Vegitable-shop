class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:show, :edit, :update, :destroy]
def index
  @cart_items = CartItem.all
  @cart_items = Product.all
end
  # GET /cart_items
  # GET /cart_items.json
  def update_cart_item_quantity
    @cart_item = CartItem.find(params[:cart_item_id])

    if params[:type] == "increase"
      cart_item.update(quantity: cart_item.quantity + 5)
      cart_item.price = cart_item.quantity * cart_item.unit_price
      cart_item.save
    elsif params[:type] == "decrease" && cart_item.quantity != 1
      cart_item.update(quantity: cart_item.quantity - 3)
        cart_item.price = cart_item.quantity * cart_item.unit_price
      cart_item.save
    end
  end

end