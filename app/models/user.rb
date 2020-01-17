class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
   devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :products, dependent: :destroy
         has_one :cart
         has_many :wishlists
         has_many :addresses
         has_many :orders
         has_many :rating_reviews, dependent: :destroy
       def current_user_cart
         "cart#{id}"
       end
       def is_admin?
          return true if self.role =="admin"
        end
        geocoded_by :address

        has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
          has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'
          has_many :personal_messages, dependent: :destroy
end
