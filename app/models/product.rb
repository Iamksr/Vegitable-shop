class Product < ApplicationRecord
  belongs_to :user
	 belongs_to :category
	  # validates_presence_of :title
        has_many :rating_reviews, dependent: :destroy
        has_many :users, through: :rating_reviews, dependent: :destroy
  # belongs_to :order, optional: true
  # has_many :orders
        has_many :order_items, dependent: :destroy
        has_many :cart_items
      mount_uploader :image, ImageUploader
      extend FriendlyId
      friendly_id :name, use: :slugged
    



  def discount_percentage
  	if price.present? && price > 0 && full_price.present? && full_price > 0
  		" " + (100 - (price.to_f / full_price.to_f * 100.0)).to_s + "%"
  	else
  		nil
  	end
  end
      
end
