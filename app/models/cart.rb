class Cart < ApplicationRecord
	belongs_to :user
	has_many :cart_items
     

     def sub_total
		cart_items.map(&:price).reject {|e| !e.present?}.sum
	end

	def quantity
		cart_items.map(&:quantity).sum
	end
	
	def discount_price
		
		cart_items.map(&:price).reject {|e| !e.present?}.sum - cart_items.map(&:unit_price).reject {|e| !e.present?}.sum 
	end
end

