class Cart < ApplicationRecord
	belongs_to :user
	has_many :cart_items
     

     def sub_total
		# cart_items.map(&:price).sum
		cart_items.map(&:price).reject {|e| !e.present?}.sum
	end

	def quantity
		cart_items.map(&:quantity).sum
	end
	
	def discount_price
		
		cart_items.map(&:price).reject {|e| !e.present?}.sum - cart_items.map(&:unit_price).reject {|e| !e.present?}.sum 
	end
#def add_cart_item(product_id)
#         cart_item = cart_items.where('product_id = ?', product_id).first
#     if cart_item
#         # increase the quantity of product in cart
#         cart_item.quantity + 1
#         saves

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
# end
end

