class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable
         has_many :products, dependent: :destroy
         has_one :cart
         has_many :wishlists
         has_many :addresses
         has_many :orders
end
