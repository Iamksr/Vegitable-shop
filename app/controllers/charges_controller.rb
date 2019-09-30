class ChargesController < ApplicationController
	def new
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


  # rescue Stripe::CardError => e
  #   flash[:error] = e.message
  #   redirect_to root_path

  end

  def show
  end

end