class ChargesController < ApplicationController
	def new
    if if current_user.present?
       
      # product_ids = current_user.cart_items.map(&:product_id)
      # @products = Product.where(id: product_ids)
    else
      redirect_to new_user_session_path
  end
end
	end

  def create
    @amount = current_cart.sub_total.to_i
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],

    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      # dee: '<%#= cart_item.product.description %>',
      currency: 'usd',
    })

   rescue Stripe::CardError => e
   flash[:error] = e.message
     redirect_to new_charges_path

  end

  def show
  end

end