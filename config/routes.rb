Rails.application.routes.draw do
  resources :cart_items
  resources :carts
  resources :categories
  resources :products do
  	 get "/cart" => "products#add_to_cart"
     get "/wishlist", action: :add_wishlist, as: :add_wishlist
  end
  get 'welcome/index'

  devise_for :users
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 get '/wishlist' => "products#wishlist"
  post '/add_to_cart/:product_id' => 'carts#add_to_cart', :as => 'add_to_cart'
  
   # resources :carts
   # resources :products
   # resources :cart_items
 
   root :to => 'products#show'
    get "/update_cart_item_quantity/:type/:cart_item_id" => "carts#update_cart_item_quantity", as: :update_cart_item_quantity

   delete 'remove_cart_item/:id' => "products#remove_cart", as: :remove_cart
end
