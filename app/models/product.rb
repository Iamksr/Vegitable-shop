class Product < ApplicationRecord
	 belongs_to :category
	  # validates_presence_of :title
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
