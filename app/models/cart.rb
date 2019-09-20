class Cart < ApplicationRecord
	belongs_to :user
	has_many :cart_items
     
#  def add_cart_item(product_id)
#         cart_item = cart_items.where('product_id = ?', product_id).first
#     if cart_item
#         # increase the quantity of product in cart
#         cart_item.quantity + 1
#         save
#     else
#         # product does not exist in cart
#         product = Product.find(product_id)
#         cart_items << product
#     end
#     save
# end

# def total_price
#     cart_items.to_a.sum(&:full_price)
# end
end

