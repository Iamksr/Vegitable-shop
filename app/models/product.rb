class Product < ApplicationRecord
	 belongs_to :category
	  # validates_presence_of :title
      mount_uploader :image, ImageUploader
      extend FriendlyId
      friendly_id :name, use: :slugged
end
