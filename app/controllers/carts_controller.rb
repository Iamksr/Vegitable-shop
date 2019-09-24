class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
    @cart_items = current_cart.cart_items
  end
def update_cart_item_quantity
  # byebug
    cart_item = CartItem.find(params[:cart_item_id])

    if params[:type] == "increase"
      cart_item.update(quantity: cart_item.quantity + 1)
      cart_item.price = cart_item.quantity * cart_item.unit_price
      cart_item.save
    elsif params[:type] == "decrease" && cart_item.quantity != 1
      cart_item.update(quantity: cart_item.quantity - 1)
        cart_item.price = cart_item.quantity * cart_item.unit_price
      cart_item.save
    end
  end

  # GET /carts/1
  # GET /carts/1.json
     def show
     @cart = current_cart
   end

   def add_to_cart
  
       @current_user.cart.cart_items(params[:product_id , :cart_id])
       redirect_to carts_path(current_cart.id)

   end



  end